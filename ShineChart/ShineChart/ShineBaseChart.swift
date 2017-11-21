//
//  ShineBaseChart.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/20.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit

class ShineBaseChart: UIView {

    /// 动画时长，不设置即无动画
    var duration : CGFloat?
    
    /// 坐标轴宽度
    var shaftWidth : CGFloat = 0.5
    
    /// 坐标轴颜色
    var shaftColor : UIColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    /// 坐标轴因为箭头的存在增加的超出部分长度
    var beyondLength : CGFloat = 20
    
    /// 边距
    var margin : CGFloat = 10
    
    /// 数据源
    var xItems : [String] = []
    
    /// 每个柱子宽度 或者每个点的直径
    var itemWidth : CGFloat = 20
    
    /// 柱子自检距离
    var xDistance : CGFloat = 20
    
    /// y轴坐标点距离
    var yDistance : CGFloat = 20
    
    /// y轴坐标点数据源
//    private var yItems : [CGFloat] = []
    
    /// y走坐标点差值
    private var ySpace : CGFloat = 0

    /// y轴坐标点个数 等于yItems.count
    var yItemCount : Int = 5
    
    /// x轴标准label颜色
    var xStepColor : UIColor = .gray
    
    /// x轴标准label背景颜色
    var xStepBgColor : UIColor = .clear
    
    /// x轴标准label高度
    var xStepHeight : CGFloat = 20
    
    /// y轴标准label颜色
    var yStepColor : UIColor = .gray
    
    /// y轴标准label背景颜色
    var yStepBgColor : UIColor = .clear
    
    /// y轴标准label宽度
    var yStepWidth : CGFloat = 30
    
    /// 字体
    var font : UIFont = UIFont.systemFont(ofSize: 12)
    
    /// 坐标点单元宽度
    var unitWidth : CGFloat = 1
    
    /// 坐标轴单元高度
    var unitHeight : CGFloat = 3
    
    /// 显示y轴坐标点
    var showYUnit : Bool = true
    
    /// 显示x轴坐标点
    var showXUnit : Bool = true
    
    /// x轴坐标点集合
    var xUnits : [CGFloat] = []
    
    /// y轴坐标点集合
    var yUnits : [CGFloat:CGFloat] = [:]

    /// 最大值
    var maxValue : CGFloat = 0
    
    /// 最小值
    var minValue : CGFloat = 0
    
    /// y轴格式化
    var format : String = "%.2f"
    
    init(frame: CGRect, xItems : [String]) {
        super.init(frame: frame)
        self.xItems = xItems
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        
        if self.backgroundColor == nil{
            self.backgroundColor = .white
        }
        
       
        
        if maxValue == 0 || yItemCount == 0{
            print("缺少Y轴最大值或者Y轴坐标点数量")
        }
        
        
        ySpace = (maxValue - minValue)/CGFloat(yItemCount)
        
        ///默认x轴第一个拒远点为半个间距 所以除数+0.5
        xDistance = (self.bounds.size.width - beyondLength - itemWidth*(CGFloat(xItems.count)) - margin * 2 - yStepWidth) / (CGFloat(xItems.count) + 0.5)
        yDistance = (self.bounds.size.height - beyondLength  - margin * 2 - xStepHeight) / (CGFloat(yItemCount))
        
    }
    
    
    
    func createShaft()  {
        var xStart : CGFloat = margin + yStepWidth
        let xRectY : CGFloat = self.bounds.size.height - margin - xStepHeight
        
        var yStart : CGFloat = xRectY
        let yRectx : CGFloat = margin + yStepWidth
        
        let xShaft = UIBezierPath()
        let xshaftLayer = CAShapeLayer()
        
        xShaft.move(to: CGPoint.init(x: xStart, y: xRectY))
        
        let xLabelWidth : CGFloat = itemWidth + xDistance
        
        var xLabelX : CGFloat = xStart + xDistance/2
        
        xStart += xDistance/2
        for item in xItems {
            
            xStart += (xDistance + itemWidth)
            
            xShaft.addLine(to: CGPoint.init(x: xStart, y: xRectY))
            
            let label = CATextLayer()
            
            let string = NSAttributedString.init(string: item, attributes:[NSAttributedStringKey.foregroundColor:self.xStepColor,NSAttributedStringKey.font:self.font])
            
            label.string = string
            
            label.isWrapped = true
            
            label.alignmentMode = kCAAlignmentCenter
            
            label.backgroundColor = xStepBgColor.cgColor
            
            label.frame = CGRect.init(x: xLabelX, y: xRectY, width: xDistance + itemWidth, height: xStepHeight)
            
            self.layer.addSublayer(label)
            
            xUnits.append(label.frame.origin.x + label.frame.size.width/2)
            
            xLabelX += xLabelWidth
            
            if showXUnit == true{
                let unitLayer = CALayer()
                unitLayer.frame = CGRect.init(x: xUnits.last!, y: xRectY - unitHeight, width: unitWidth, height: unitHeight)
                unitLayer.backgroundColor = shaftColor.cgColor
                self.layer.addSublayer(unitLayer)
            }
            
            
        }
        
        if beyondLength != 0{
            xStart+=beyondLength
            xShaft.addLine(to: CGPoint.init(x:xStart, y: xRectY))
        }
        
        xshaftLayer.path = xShaft.cgPath
        xshaftLayer.lineWidth = shaftWidth
        xshaftLayer.strokeColor = shaftColor.cgColor
        xshaftLayer.lineCap = kCALineCapButt
        
        self.layer.addSublayer(xshaftLayer)
      
        //MARK: y轴
        let yShaft = UIBezierPath()
        let yShaftLayer = CAShapeLayer()
        yShaft.move(to: CGPoint.init(x: yRectx, y: yStart))
        
        
        for index in 1...yItemCount {
            yStart -= yDistance
            
            
            if showYUnit == true{
                if xDistance != 0 {
                    let unitLayer = CALayer()
                    unitLayer.frame = CGRect.init(x: yRectx, y: yStart, width: unitHeight, height: unitWidth)
                    unitLayer.backgroundColor = shaftColor.cgColor
                    
                    self.layer.addSublayer(unitLayer)
                }
            }
            
            
            yShaft.addLine(to: CGPoint.init(x: yRectx, y: yStart))
            
            let label = CATextLayer()
            
            let currenValue = ySpace * CGFloat(index)
            
            let text = String(format: format,currenValue + minValue)
            
            
            let string = NSAttributedString.init(string: text, attributes:[NSAttributedStringKey.foregroundColor:self.yStepColor,NSAttributedStringKey.font:self.font])
            
            let yLabelHeight = getHeight(str: text, width: yStepWidth)
            
            label.string = string
            
            label.isWrapped = true
            
            label.alignmentMode = kCAAlignmentCenter
            
            label.backgroundColor = yStepBgColor.cgColor
            
            label.frame = CGRect.init(x: margin, y: yStart - yLabelHeight/2, width: yStepWidth, height: yLabelHeight)
            
            self.layer.addSublayer(label)
            
            yUnits[currenValue] = yStart
            
        }
        
        if  beyondLength != 0 {
            yStart -= beyondLength
            yShaft.addLine(to: CGPoint.init(x: yRectx, y: yStart))

        }
        
        yShaftLayer.path = yShaft.cgPath
        yShaftLayer.lineWidth = shaftWidth
        yShaftLayer.strokeColor = shaftColor.cgColor
        yShaftLayer.lineCap = kCALineCapButt
        
        self.layer.addSublayer(yShaftLayer)
        
        
    }
    
    func getHeight(str:String,width:CGFloat) -> CGFloat{
        
        let size = CGSize.init(width: width, height: 1000)
        let dict = [NSAttributedStringKey.foregroundColor:self.yStepColor,NSAttributedStringKey.font:self.font] as [NSAttributedStringKey : Any]
        
        let newStr : NSString = str as NSString
        
       let rect = newStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict, context: nil)
        
        return rect.size.height
    }
    
    func createLayer() {
        
    }
    

    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configuration()
        
        createShaft()
        
        createLayer()
    }

}
