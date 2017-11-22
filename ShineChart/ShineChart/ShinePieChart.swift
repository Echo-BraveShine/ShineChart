//
//  ShinePieChart.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/20.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit


let ShinePI = CGFloat(Double.pi*2)
/// 扇形的配置
public struct ShinePieItem {
    
    var color = UIColor.clear
    
    var value : CGFloat = 0.0
    
    var title : String = ""
    
    public init(color: UIColor,value: CGFloat,title : String? = nil) {
        self.color = color
        self.value = value
        self.title = title ?? ""
    }
}

public class ShinePieChart: UIView {
    
    
    /// 中间圆的半径
    public var ringRadius : CGFloat = 0
    
    /// 扇形集合
    public var items : [ShinePieItem] = []
    
    /// 动画时长，不设置即无动画
    public var duration : CGFloat?
    
    /// 起始绘制方向 x轴正向为0  x轴负向为整数0.5 y轴正向为0.75 y轴负向为0.25
    public var startAngle : CGFloat = 0
    
    /// 是否显示描述
    public var showDescription : Bool = true
    
    /// 描述字体
    public var font : UIFont = UIFont.systemFont(ofSize: 14)
    
    /// number格式化
    public var format : String = "%.2f"
    
    public var textColor : UIColor = UIColor.white
    init(frame: CGRect,items:[ShinePieItem]) {
        super.init(frame: frame)
        
        self.items = items
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawPie() {
        
        if items.count == 0 {
            return
        }
        
        var sumValue : CGFloat = 0
        
        for item in items {
            sumValue += item.value
        }
        
        let radius = min(self.frame.size.width/2, self.frame.size.height/2)
        
        var startAngle  = self.startAngle
        
        var endAngle = self.startAngle
        
        let center = CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2 )
        
        let prentLayer = CAShapeLayer.init(layer: self.layer)
        
        prentLayer.mask = self.createLayer(arcCenter: center, radius: radius/2, startAngle: startAngle*ShinePI, endAngle: ShinePI*(startAngle + 1), lineWidth: radius, fillColor: .clear, strokColor: self.backgroundColor ?? .white)
        
        self.layer.addSublayer(prentLayer)
        
        for item in items{
            
            endAngle = item.value/sumValue + startAngle
            
            let ringWidth  = (radius - ringRadius)
            
            let shaperLayer = createLayer(arcCenter: center, radius: radius - ringWidth/2, startAngle: startAngle*ShinePI, endAngle: endAngle*ShinePI, lineWidth: ringWidth, fillColor: .clear, strokColor: item.color)
            prentLayer.addSublayer(shaperLayer)
            
            description(item: item, startAngle: startAngle, endAngle: endAngle,layer : shaperLayer)
            
            startAngle = endAngle
        }
        
        
        if duration != nil  {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.isRemovedOnCompletion = true
            animation.duration = CFTimeInterval(self.duration!)
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            prentLayer.mask?.add(animation, forKey: "")
        }
    }
    
    
    func createLayer(arcCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat,lineWidth:CGFloat,fillColor: UIColor,strokColor: UIColor)-> CAShapeLayer {
        let lay = CAShapeLayer()
        let path = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        lay.path = path.cgPath
        lay.fillColor = fillColor.cgColor
        lay.strokeColor = strokColor.cgColor
        lay.lineWidth = lineWidth
        lay.lineCap = kCALineCapButt
        return lay
    }
    
    
    func description(item:ShinePieItem,startAngle : CGFloat,endAngle: CGFloat,layer : CAShapeLayer)  {
        
        let radius = min(self.frame.size.width/2, self.frame.size.height/2)
        
        /// 以x轴为0 所以要加 0.25pi
        let midPercentage = (startAngle + endAngle)/2 * ShinePI  + 0.25 * ShinePI
        
        let space = radius - (radius - ringRadius)/2
        
        let label = CATextLayer() //UILabel.init(frame: CGRect.init(x: 0, y: 0, width: space, height: 100))
        
        let text = String(format: format, (endAngle - startAngle)*100) + "\n"  +  item.title
        
        //        label.text = String(format: "%.2f", (endAngle - startAngle)*100) + "\n"  +  item.title
        let string = NSAttributedString.init(string: text, attributes:[NSAttributedStringKey.foregroundColor:self.textColor,NSAttributedStringKey.font:self.font])
        
        label.string = string
        
        let center = CGPoint(x: self.bounds.size.width/2 + space * CGFloat(sin(midPercentage))  , y: self.bounds.size.height/2 - space * CGFloat(cos(midPercentage)))
        
        let size = text.size(withAttributes: [NSAttributedStringKey.font: self.font])
        
        label.frame = CGRect.init(x: 0 , y: 0, width: (size.width), height: (size.height))
        
        label.isWrapped = true
        
        label.alignmentMode = kCAAlignmentCenter
        
        label.backgroundColor = UIColor.clear.cgColor
        
        label.position = center
        
        layer.addSublayer(label)
        
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        drawPie()
    }
    
}
