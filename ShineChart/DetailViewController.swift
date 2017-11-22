//
//  DetailViewController.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/21.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    enum Style {
        case pie,line,bar
    }
    
    var style : Style = .pie
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch style {
        case .line:
            lineChart1()
            lineChart2()
            lineChart3()
            lineChart4()
            break
        case .bar:
            barChart()
            break
        default:
            pieChart()
        }
        
        self.view.backgroundColor = .white
    }

    func lineChart1()  {
        
        let line1 = ShineLine.init(color: .black,source: [0.2,0.4,0.6,0.2,0.8,0.7])
        
        let line2 = ShineLine.init(color: .red,source: [0.3,0.2,0.8,0.5,0.6,0.9])
        
        let bar = ShineLineChart.init(frame: CGRect.init(x: 0, y: 90, width: 375, height: 150), xItems: ["1","2","3","4","5","6"])
        
        bar.maxValue = 1
        
        bar.yItemCount = 5
        
        bar.lines = [line1,line2]
        
        bar.duration = 2
        
        bar.style = .scatter
        
        bar.shaftStyle = .arrow
        
        bar.xShaftTitle = "X"
        bar.yShaftTitle = "Y"
//        bar.xStepBgColor = UIColor.blue
        
        self.view.addSubview(bar)
        
        
    }
    func lineChart2()  {
        
        let line1 = ShineLine.init(color: .black,source: [0.2,0.4,0.6,0.2,0.8,0.7])
        
        let line2 = ShineLine.init(color: .red,source: [0.3,0.2,0.8,0.5,0.6,0.9])
        
        let bar = ShineLineChart.init(frame: CGRect.init(x: 0, y: 250, width: 375, height: 150), xItems: ["1","2","3","4","5","6"])
        
        bar.maxValue = 1
        
        bar.yItemCount = 5
        
        bar.lines = [line1,line2]
        
        bar.duration = 2
        
        bar.style = .line(type: .normal)
        
        
        self.view.addSubview(bar)
        
        
    }
    
    func lineChart3()  {
        
        
        let line1 = ShineLine.init(color: .black,source: [0.2,0.4,0.6,0.2,0.8,0.7])
        
        let line2 = ShineLine.init(color: .red,source: [0.3,0.2,0.8,0.5,0.6,0.9])
        
        let bar = ShineLineChart.init(frame: CGRect.init(x: 0, y: 420, width: 375, height: 150), xItems: ["1","2","3","4","5","6"])
        
        bar.maxValue = 1
        
        bar.yItemCount = 5
        
        bar.lines = [line1,line2]
        
        bar.duration = 2
        
        bar.style = .line(type: .dot)
        
        self.view.addSubview(bar)
        
        
    }
    
    func lineChart4()  {
        
        
        let line1 = ShineLine.init(color: .black,source: [0.2,0.4,0.6,0.2,0.8,0.7])
        
        let line2 = ShineLine.init(color: .red,source: [0.3,0.2,0.8,0.5,0.6,0.9])
        
        let bar = ShineLineChart.init(frame: CGRect.init(x: 0, y: 580, width: 375, height: 150), xItems: ["1","2","3","4","5","6"])
        
        bar.maxValue = 1
        
        bar.yItemCount = 5
        
        bar.lines = [line1,line2]
        
        bar.duration = 2
        
        bar.style = .line(type: .ring)
        
        self.view.addSubview(bar)
        
        
    }
    
    
    func barChart()  {
        
        let bar1 = ShineBar.init(color: .green, value: 0.5)
        let bar2 = ShineBar.init(color: .red, value: 0.8)
        let bar3 = ShineBar.init(color: .black, value: 0.3)
        let bar4 = ShineBar.init(color: .purple, value: 0.1)
        let bar5 = ShineBar.init(color: .cyan, value: 0.9)
        let bar6 = ShineBar.init(color: .yellow, value: 0.4)
        
        let bar = ShineBarChart.init(frame: CGRect.init(x: 0, y: 350, width: 375, height: 200), xItems: ["1","2","3","4","5","6"])
        
        bar.maxValue = 1 //y轴最大值
        
        bar.yItemCount = 5 //y轴坐标点个数
        
        bar.bars = [bar1,bar2,bar3,bar4,bar5,bar6]
        
        bar.duration = -2
        
        bar.xShaftTitle = "X"
        
        bar.yShaftTitle = "Y"
        
        bar.center = self.view.center
        
        self.view.addSubview(bar)
        
        
    }
    
    func pieChart()  {
        let item1 = ShinePieItem.init(color: .red, value: 0.7,title: "redcolor")
        let item2 = ShinePieItem.init(color: .blue, value: 0.2,title: "bluecolor")
        let item3 = ShinePieItem.init(color: .purple, value: 0.3,title: "purplecolor")
        
        let pie = ShinePieChart.init(frame: CGRect.init(x: 0, y: 100, width: 300, height: 200), items: [item1,item2,item3])
        
        pie.ringRadius = 20
        
        pie.startAngle = 0.2
        
        pie.font = UIFont.systemFont(ofSize: 12)
        
        pie.duration = 3
        
        pie.center = self.view.center
        
        view.addSubview(pie)
    }
    
    deinit {
        print("deinit")
    }
}
