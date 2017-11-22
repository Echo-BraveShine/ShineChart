//
//  ShineBarChart.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/20.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit

public struct ShineBar {
    
    var color : UIColor
    
    var values : [CGFloat]
    
    /// 柱状图
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - value: 数据集合
    public init(color: UIColor = .gray, value: [CGFloat] = []) {
        
        self.color = color
        
        self.values = value
    }
    
}

public class ShineBarChart: ShineBaseChart {
    
    /// 柱状图集合
    public var bars : [ShineBar] = []
    
    override func createLayer() {
        if bars.count == 0 {
            return
        }
        let contentH = (self.bounds.size.height - 2 * margin - xStepHeight - beyondLength)
        
        let xShaft : CGFloat = self.bounds.size.height - margin - xStepHeight - shaftWidth
        
        for (index,item) in bars.enumerated() {
            
            for (idx,value) in item.values.enumerated() {
                
                if idx >= xUnits.count {
                    continue
                }
                
                let unit = xUnits[idx]
                
                let barWidth = itemWidth/CGFloat(bars.count)
                
                let barUint = unit - itemWidth/2 + barWidth * (CGFloat(index) + 0.5)
                
                let y = (maxValue - value)/maxValue  *  contentH + margin + beyondLength
                let path = UIBezierPath()
                path.move(to: CGPoint.init(x: barUint, y: xShaft))
                path.addLine(to: CGPoint.init(x: barUint, y: y))
                path.lineWidth = 10
                
                let lay = CAShapeLayer()
                lay.path = path.cgPath
                lay.lineWidth = barWidth
                lay.strokeColor = item.color.cgColor
                lay.lineCap = kCALineCapButt
                self.layer.addSublayer(lay)
                
                if duration != nil{
                    let animation = CABasicAnimation(keyPath: "strokeEnd")
                    animation.fromValue = 0
                    animation.toValue = 1
                    animation.isRemovedOnCompletion = false
                    animation.fillMode = kCAFillModeForwards
                    animation.duration = CFTimeInterval(self.duration!)
                    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                    
                    lay.add(animation, forKey: "")
                    
                }
            }
        }
        
        
    }
    
    override public func layoutSubviews() {
        showXUnit = false
        super.layoutSubviews()
    }
    
}
