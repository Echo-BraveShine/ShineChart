//
//  ShineBaseChart.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/20.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit

class ShineBaseItem : NSObject{
    
    var color = UIColor.clear
    
    var value : CGFloat = 0.0
    
    var title : String = ""
    
    
}
class ShineBaseChart: UIView {

    /// 坐标轴宽度
    var shaftWidth : CGFloat = 0.5
    
    /// 坐标轴颜色
    var shaftColor : UIColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    /// 坐标轴因为箭头的存在增加的超出部分长度
    var beyondLength : CGFloat = 20
    
    /// 边距
    var margin : CGFloat = 10
    
    /// 数据源
    var items : [ShineBaseItem] = []
    
    /// 每个柱子宽度 或者每个点的直径
    var itemWidth : CGFloat = 20
    
    /// 柱子自检距离
    var xDistance : CGFloat = 20
    
    /// y轴坐标点距离
    var yDistance : CGFloat = 20
    
    /// y轴坐标点数据源
    var yItems : [CGFloat] = []
    
    /// x轴标准label颜色
    var xStepColor : UIColor = .black
    
    /// x轴标准label背景颜色
    var xStepBgColor : UIColor = .clear
    
    /// x轴标准label高度
    var xStepHeight : CGFloat = 20
    
    /// y轴标准label颜色
    var yStepColor : UIColor = .black
    
    /// y轴标准label背景颜色
    var yStepBgColor : UIColor = .clear
    
    /// y轴标准label宽度
    var yStepWidth : CGFloat = 30
    
    /// 字体
    var font : UIFont = UIFont.systemFont(ofSize: 14)
    
    /// 坐标点单元宽度
    var unitWidth : CGFloat = 1
    
    /// 坐标轴单元高度
    var unitHeight : CGFloat = 3
    
    /// 显示y轴坐标点
    var showYUnit : Bool = true
    
    /// 显示x轴坐标点
    var showXUnit : Bool = true
    
    init(frame: CGRect, items : [ShineBaseItem]) {
        super.init(frame: frame)
        self.items = items
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration() {
        
        if self.backgroundColor == nil{
            self.backgroundColor = .white
        }
        
        ///默认xy轴第一个拒远点为半个间距 所以除数+0.5
        xDistance = (self.bounds.size.width - beyondLength - itemWidth*(CGFloat(items.count)) - margin * 2 - yStepWidth) / (CGFloat(items.count) + 0.5)
        yDistance = (self.bounds.size.height - beyondLength  - margin * 2 - xStepHeight) / (CGFloat(yItems.count) + 0.5)
        
    }
    
    func createShaft()  {
        var xStart : CGFloat = margin + yStepWidth
        let xRectY : CGFloat = self.bounds.size.height - margin - xStepHeight
        
        var yStart : CGFloat = xRectY
        let yRectx : CGFloat = margin + yStepWidth
        
        let xShaft = UIBezierPath()
        
        xShaft.move(to: CGPoint.init(x: xStart, y: xRectY))
        
        let xLabelWidth : CGFloat = itemWidth + xDistance
        
        var xLabelX : CGFloat = xStart + xDistance/2
        
        xStart += xDistance/2
        for item in items {
            
            xStart += (xDistance + itemWidth)
            
            xShaft.addLine(to: CGPoint.init(x: xStart, y: xRectY))
            
            let label = CATextLayer()
            
            let string = NSAttributedString.init(string: item.title, attributes:[NSAttributedStringKey.foregroundColor:self.xStepColor,NSAttributedStringKey.font:self.font])
            
            label.string = string
            
            label.isWrapped = true
            
            label.alignmentMode = kCAAlignmentCenter
            
            label.backgroundColor = xStepBgColor.cgColor
            
            label.frame = CGRect.init(x: xLabelX, y: xRectY, width: xDistance + itemWidth, height: xStepHeight)
            
            self.layer.addSublayer(label)
            
            xLabelX += xLabelWidth
            
            if showXUnit == true{
                let unitLayer = CALayer()
                unitLayer.frame = CGRect.init(x: label.frame.origin.x + label.frame.size.width/2, y: xRectY - unitHeight, width: unitWidth, height: unitHeight)
                unitLayer.backgroundColor = shaftColor.cgColor
                
                self.layer.addSublayer(unitLayer)
            }
            
            
        }
        
        if beyondLength != 0{
            xStart+=beyondLength
            xShaft.addLine(to: CGPoint.init(x:xStart, y: xRectY))
        }
        
        shaftColor.set()
        xShaft.lineWidth = shaftWidth
        xShaft.stroke()
        
        //MARK: y轴
        let yShaft = UIBezierPath()
        yShaft.move(to: CGPoint.init(x: yRectx, y: yStart))
        let yLabelHeight : CGFloat = yDistance
        
        var yLabelY : CGFloat = yStart - yLabelHeight*1.5
        
        yStart -= yDistance/2
        
        for item in yItems {
            yStart -= yDistance
            
            yShaft.addLine(to: CGPoint.init(x: yRectx, y: yStart))
            
            let label = CATextLayer()
            
            let string = NSAttributedString.init(string: String(describing: item), attributes:[NSAttributedStringKey.foregroundColor:self.yStepColor,NSAttributedStringKey.font:self.font])
            
            label.string = string
            
            label.isWrapped = true
            
            label.alignmentMode = kCAAlignmentCenter
            
            label.backgroundColor = yStepBgColor.cgColor
            
            label.frame = CGRect.init(x: margin, y: yLabelY, width: yStepWidth, height: yLabelHeight)
            
            self.layer.addSublayer(label)
            
            yLabelY -= yLabelHeight
            
            
            if showYUnit == true{
                if xDistance != 0 {
                    let unitLayer = CALayer()
                    unitLayer.frame = CGRect.init(x: yRectx, y: label.frame.origin.y + label.frame.size.height/2, width: unitHeight, height: unitWidth)
                    unitLayer.backgroundColor = shaftColor.cgColor
                    
                    self.layer.addSublayer(unitLayer)
                }
            }
            
        }
        
        if  beyondLength != 0 {
            yStart -= beyondLength
            yShaft.addLine(to: CGPoint.init(x: yRectx, y: yStart))

        }
        
        shaftColor.set()
        yShaft.lineWidth = shaftWidth
        yShaft.stroke()
        
        
    }
    
    func createLayer() {
        
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        if items.count == 0 {
            return
        }
        
        createShaft()
        
        createLayer()
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        configuration()
    }

}
