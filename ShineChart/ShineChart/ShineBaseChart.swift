//
//  ShineBaseChart.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/20.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit

/// ShineBarChart SineLineChart 的父类 主要负责创建坐标系
public class ShineBaseChart: UIView {
    
    /// 坐标轴样式
    ///
    /// - normal: 默认样式
    /// - arrow: 终点带箭头样式
    public enum ShaftStyle {
        case normal,arrow
    }
    
    /// 坐标轴样式
    public var shaftStyle : ShaftStyle = .normal
    
    /// 动画时长，不设置即无动画
    public var duration : CGFloat?
    
    /// 坐标轴宽度
    public var shaftWidth : CGFloat = 0.5
    
    /// 坐标轴颜色
    public var shaftColor : UIColor = UIColor.lightGray.withAlphaComponent(0.5)
    
    /// 坐标轴因为箭头的存在增加的超出部分长度
    public var beyondLength : CGFloat = 20
    
    /// x轴标题
    public var xShaftTitle : String = ""
    
    /// y轴标题
    public var yShaftTitle : String = ""
    
    /// 边距
    public var margin : CGFloat = 10
    
    /// 数据源
    public var xItems : [String] = []
    
    /// 每个柱子宽度 或者每个点的直径
    public var itemWidth : CGFloat = 20
    
    /// 柱子自检距离
    public var xDistance : CGFloat = 20
    
    /// y轴坐标点距离
    public var yDistance : CGFloat = 20
    
    /// y轴坐标点数据源
    //    private var yItems : [CGFloat] = []
    
    /// y走坐标点差值
    private var ySpace : CGFloat = 0
    
    /// y轴坐标点个数 等于yItems.count
    public var yItemCount : Int = 5
    
    /// x轴标准label颜色
    public var xStepColor : UIColor = .gray
    
    /// x轴标准label背景颜色
    public var xStepBgColor : UIColor = .clear
    
    /// x轴标准label高度
    public var xStepHeight : CGFloat = 20
    
    /// y轴标准label颜色
    public var yStepColor : UIColor = .gray
    
    /// y轴标准label背景颜色
    public var yStepBgColor : UIColor = .clear
    
    /// y轴标准label宽度
    public var yStepWidth : CGFloat = 30
    
    /// 字体
    public var font : UIFont = UIFont.systemFont(ofSize: 12)
    
    /// 坐标点单元宽度
    public var unitWidth : CGFloat = 1
    
    /// 坐标轴单元高度
    public var unitHeight : CGFloat = 3
    
    /// 显示y轴坐标点
    public var showYUnit : Bool = true
    
    /// 显示x轴坐标点
    public var showXUnit : Bool = true
    
    /// x轴坐标点集合
    public var xUnits : [CGFloat] = []
    
    //    /// y轴坐标点集合
    //    public var yUnits : [CGFloat:CGFloat] = [:]
    
    /// 最大值
    public var maxValue : CGFloat = 0
    
    /// 最小值
    public var minValue : CGFloat = 0
    
    /// y轴格式化
    public var format : String = "%.1f"
    
    
    
    init(frame: CGRect, xItems : [String]) {
        super.init(frame: frame)
        self.xItems = xItems
    }
    required public init?(coder aDecoder: NSCoder) {
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
    
    
    
    /// 绘制坐标系
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
        for (index,item) in xItems.enumerated() {
            
            xStart += (xDistance + itemWidth)
            
            let label = createTextLayer(frame: CGRect.init(x: xLabelX, y: xRectY, width: xDistance + itemWidth, height: xStepHeight), item: item,titleColor: self.xStepColor,BgColor: self.xStepBgColor)
            
            self.layer.addSublayer(label)
            
            xUnits.append(label.frame.origin.x + label.frame.size.width/2)
            
            xLabelX += xLabelWidth
            
            
            ///绘制x轴标题
            if index == xItems.count - 1 && xShaftTitle.count != 0{
                
                let label = createTextLayer(frame: CGRect.init(x: xLabelX , y: xRectY, width: beyondLength, height: xStepHeight), item: xShaftTitle,titleColor: self.xStepColor,BgColor: self.xStepBgColor)
                
                self.layer.addSublayer(label)
            }
            
            
            
            
            if showXUnit == true{
                let unitLayer = CALayer()
                unitLayer.frame = CGRect.init(x: xUnits.last!, y: xRectY - unitHeight, width: unitWidth, height: unitHeight)
                unitLayer.backgroundColor = shaftColor.cgColor
                self.layer.addSublayer(unitLayer)
            }
            
        }
        
        if beyondLength != 0{
            xStart+=beyondLength
        }
        
        xShaft.addLine(to: CGPoint.init(x:xStart, y: xRectY))
        
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
            
            
            let currenValue = ySpace * CGFloat(index)
            
            let text = String(format: format,currenValue + minValue)
            
            let yLabelHeight = getHeight(str: text, width: yStepWidth)
            
            
            
            let label = createTextLayer(frame: CGRect.init(x: margin, y: yStart - yLabelHeight/2, width: yStepWidth, height: yLabelHeight), item: text, titleColor: self.yStepColor, BgColor: self.yStepBgColor)
            
            self.layer.addSublayer(label)
            
            ///绘制y轴标题
            if index == yItemCount && yShaftTitle.count != 0 {
                
                let label = createTextLayer(frame: CGRect.init(x: margin, y: yStart - beyondLength, width: yStepWidth, height: beyondLength - yLabelHeight/2), item: yShaftTitle, titleColor: self.yStepColor, BgColor: self.yStepBgColor)
                
                self.layer.addSublayer(label)
            }
            
        }
        
        if  beyondLength != 0 {
            yStart -= beyondLength
        }
        yShaft.addLine(to: CGPoint.init(x: yRectx, y: yStart))
        
        yShaftLayer.path = yShaft.cgPath
        yShaftLayer.lineWidth = shaftWidth
        yShaftLayer.strokeColor = shaftColor.cgColor
        yShaftLayer.lineCap = kCALineCapButt
        self.layer.addSublayer(yShaftLayer)
        
        
        if self.shaftStyle == .arrow {
            createShaftArraw(xStart: xStart, xRectY: xRectY, yRectx: yRectx, yStart: yStart)
        }
        
    }
    
    
    /// 创建文本CATextLayer
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - item: 文本
    ///   - titleColor: 字体颜色
    ///   - BgColor: 背景颜色
    /// - Returns: CATextLayer
    func createTextLayer(frame: CGRect,item : String,titleColor:UIColor,BgColor : UIColor) -> CATextLayer {
        let label = CATextLayer()
        
        let string = NSAttributedString.init(string: item, attributes:[NSAttributedStringKey.foregroundColor:titleColor,NSAttributedStringKey.font:self.font])
        
        label.string = string
        
        label.isWrapped = true
        
        label.alignmentMode = kCAAlignmentCenter
        
        label.backgroundColor = BgColor.cgColor
        
        label.frame = frame
        
        return label
    }
    
    
    /// 绘制箭头
    ///
    /// - Parameters:
    ///   - xStart: x轴终点x
    ///   - xRectY: x轴终点y
    ///   - yRectx: y轴终点x
    ///   - yStart: y轴终点y
    func createShaftArraw(xStart : CGFloat,xRectY : CGFloat,yRectx : CGFloat,yStart: CGFloat)  {
        let arrawWidth : CGFloat = 5
        
        let xArrawPath = UIBezierPath()
        
        xArrawPath.move(to: CGPoint.init(x: xStart - arrawWidth, y: xRectY - arrawWidth))
        
        xArrawPath.addLine(to: CGPoint.init(x: xStart, y: xRectY))
        
        xArrawPath.addLine(to: CGPoint.init(x: xStart - arrawWidth, y: xRectY + arrawWidth))
        
        let xarrawLayer = CAShapeLayer()
        
        xarrawLayer.path = xArrawPath.cgPath
        
        xarrawLayer.lineWidth = shaftWidth
        xarrawLayer.strokeColor = shaftColor.cgColor
        
        xarrawLayer.fillColor = UIColor.clear.cgColor
        xarrawLayer.lineCap = kCALineCapButt
        
        self.layer.addSublayer(xarrawLayer)
        
        
        let yArrawPath = UIBezierPath()
        
        yArrawPath.move(to: CGPoint.init(x: yRectx - arrawWidth, y: yStart + arrawWidth))
        
        yArrawPath.addLine(to: CGPoint.init(x: yRectx, y: yStart))
        
        yArrawPath.addLine(to: CGPoint.init(x: yRectx + arrawWidth, y: yStart + arrawWidth))
        
        let yarrawLayer = CAShapeLayer()
        
        yarrawLayer.path = yArrawPath.cgPath
        
        yarrawLayer.lineWidth = shaftWidth
        yarrawLayer.strokeColor = shaftColor.cgColor
        
        yarrawLayer.fillColor = UIColor.clear.cgColor
        yarrawLayer.lineCap = kCALineCapButt
        
        self.layer.addSublayer(yarrawLayer)
    }
    
    /// 获取文本高度
    ///
    /// - Parameters:
    ///   - str: 文本
    ///   - width: 宽度
    /// - Returns: 高度
    func getHeight(str:String,width:CGFloat) -> CGFloat{
        let size = CGSize.init(width: width, height: 1000)
        let dict = [NSAttributedStringKey.foregroundColor:self.yStepColor,NSAttributedStringKey.font:self.font] as [NSAttributedStringKey : Any]
        let newStr : NSString = str as NSString
        let rect = newStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dict, context: nil)
        return rect.size.height
    }
    
    /// 进行数据绘制 交由子类实现
    func createLayer() {}
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        configuration()
        
        createShaft()
        
        createLayer()
    }
    
}
