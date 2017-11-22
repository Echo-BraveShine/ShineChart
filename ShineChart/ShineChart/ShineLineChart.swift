//
//  ShineLineChart.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/20.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit

public struct ShineLine {
    
    /// 线的颜色
    var color : UIColor
    
    /// 线的节点集合
    var source : [CGFloat]
    
    /// 线的宽度
    var lineWidth : CGFloat
    
    /// 节点颜色
    var nodeColor : UIColor
    
    /// 节点半径
    var nodeRadius : CGFloat
    
    public init(color: UIColor = .black, source: [CGFloat] = [],lineWidth: CGFloat = 1,nodeColor: UIColor? = nil,nodeRadius: CGFloat = 2) {
        
        
        self.color = color
        self.source = source
        self.lineWidth = lineWidth
        
        if nodeColor != nil {
            self.nodeColor = nodeColor!
        }else{
            self.nodeColor = color
        }
        
        self.nodeRadius = nodeRadius
    }
}

public class ShineLineChart: ShineBaseChart {
    
    /// 折线图样式
    ///
    /// - normal: 默认样式
    /// - dot: 节点为圆点
    /// - ring: 节点为圆环
    /// - line: 折线图
    /// - scatter: 散点图
    public enum ShineLineStyle {
        public enum LineNode {
            case normal,dot,ring
        }
        case line(type: LineNode)
        case scatter
    }
    
    /// 折线图样式
    public var style : ShineLineStyle = .line(type: .normal)
    
    /// 折线图多条线集合
    public var lines : [ShineLine] = []
    
    
    override func createLayer() {
        
        if lines.count == 0 {
            return
        }
        
        switch style {
            
        case .line(type: .dot):
            createLine(type: .dot)
            
            break
            
        case .line(type: .ring):
            createLine(type: .ring)
            break
            
        case .scatter:
            
            createScatter()
            
            break
        default:
            createLine(type: .normal)
            
        }
        
    }
    
    func createScatter()  {
        let contentH = (self.bounds.size.height - 2 * margin - xStepHeight - beyondLength)
        
        for line in lines {
            
            for (index,item) in line.source.enumerated() {
                if index < xUnits.count {
                    
                    let x = xUnits[index]
                    
                    let y = (maxValue-item)/maxValue  *  contentH + margin + beyondLength
                    
                    let point = CGPoint.init(x: x, y: y)
                    
                    let dotLayer = CAShapeLayer()
                    let dotpath : UIBezierPath = UIBezierPath.init(arcCenter: point, radius: line.nodeRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
                    
                    dotLayer.path = dotpath.cgPath
                    dotLayer.strokeColor = line.nodeColor.cgColor
                    
                    dotLayer.lineWidth = line.nodeRadius
                    dotLayer.fillColor = line.nodeColor.cgColor
                    
                    dotLayer.lineCap = kCALineCapButt
                    
                    self.layer.addSublayer(dotLayer)
                }
            }
        }
    }
    
    /// 画折线图
    func createLine(type : ShineLineStyle.LineNode)  {
        
        let contentH = (self.bounds.size.height - 2 * margin - xStepHeight - beyondLength)
        
        for line in lines {
            
            let path = UIBezierPath()
            
            let lineLayer = CAShapeLayer()
            
            for (index,item) in line.source.enumerated() {
                
                if index < xUnits.count {
                    
                    let x = xUnits[index]
                    
                    let y = (maxValue-item)/maxValue  *  contentH + margin + beyondLength
                    
                    let point = CGPoint.init(x: x, y: y)
                    
                    if index == 0{
                        path.move(to: point)
                    }else{
                        path.addLine(to: point)
                    }
                    
                    
                    if type != .none {
                        
                        let dotLayer = CAShapeLayer()
                        let dotpath : UIBezierPath = UIBezierPath.init(arcCenter: point, radius: line.nodeRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
                        
                        dotLayer.path = dotpath.cgPath
                        dotLayer.strokeColor = line.nodeColor.cgColor
                        
                        if type == .ring {
                            dotLayer.lineWidth = line.nodeRadius/2
                            dotLayer.fillColor = (self.backgroundColor ?? .white).cgColor
                            
                        }else{
                            dotLayer.lineWidth = line.nodeRadius
                            dotLayer.fillColor = line.nodeColor.cgColor
                            
                        }
                        
                        dotLayer.lineCap = kCALineCapButt
                        
                        self.layer.addSublayer(dotLayer)
                        
                    }
                }
                
            }
            
            lineLayer.path = path.cgPath
            
            lineLayer.strokeColor = line.color.cgColor
            
            lineLayer.fillColor = UIColor.clear.cgColor
            
            lineLayer.lineWidth = line.lineWidth
            
            lineLayer.lineCap = kCALineCapButt
            
            lineLayer.backgroundColor = UIColor.red.cgColor
            self.layer.addSublayer(lineLayer)
            
            if duration != nil{
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = 0
                animation.toValue = 1
                animation.isRemovedOnCompletion = false
                animation.fillMode = kCAFillModeForwards
                animation.duration = CFTimeInterval(self.duration!)
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                
                lineLayer.add(animation, forKey: "")
            }
        }
    }
    
}
