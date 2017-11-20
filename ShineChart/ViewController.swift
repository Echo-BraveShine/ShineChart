//
//  ViewController.swift
//  ShineChart
//
//  Created by BraveShine on 2017/11/15.
//  Copyright © 2017年 BraveShine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        lineChart()
    }
    
    func lineChart()  {
        let item1 = ShineLineItem.init(color: .red, value: 0.7,title: "1")
        let item2 = ShineLineItem.init(color: .blue, value: 0.2,title: "2")
        let item3 = ShineLineItem.init(color: .green, value: 0.3,title: "3")
        let item4 = ShineLineItem.init(color: .green, value: 0.1,title: "4")
        let item5 = ShineLineItem.init(color: .green, value: 0.6,title: "5")
        let item6 = ShineLineItem.init(color: .green, value: 0.9,title: "6")
        let item7 = ShineLineItem.init(color: .green, value: 0.4,title: "7")
        
        let bar = ShineLineChart.init(frame: CGRect.init(x: 0, y: 350, width: 375, height: 200),items: [item1,item2,item3,item4,item5,item6,item7])
        
        bar.yItems = [0.2,0.4,0.6,0.8,1.0,1.2,1.4]
        

//        bar.backgroundColor = .red
//        bar.xStepBgColor = UIColor.blue
        view.addSubview(bar)
    }
    
    func barChart()  {
        
        let item1 = ShineBarItem.init(color: .red, value: 0.7,title: "1")
        let item2 = ShineBarItem.init(color: .blue, value: 0.2,title: "2")
        let item3 = ShineBarItem.init(color: .green, value: 0.3,title: "3")
        let item4 = ShineBarItem.init(color: .green, value: 0.1,title: "4")
        let item5 = ShineBarItem.init(color: .green, value: 0.6,title: "5")
        let item6 = ShineBarItem.init(color: .green, value: 0.9,title: "6")
        let item7 = ShineBarItem.init(color: .green, value: 0.4,title: "7")

        let bar = ShineBarChart.init(frame: CGRect.init(x: 0, y: 350, width: 375, height: 200),items: [item1,item2,item3,item4,item5,item6,item7])
        
        
        bar.yItems = [0.2,0.4,0.6,0.8,1.0,1.2,1.4]
        
        view.addSubview(bar)
        
        
    }
    
    func pieChart()  {
        let item1 = ShinePieItem.init(color: .red, value: 0.7,title: "redcolor")
        let item2 = ShinePieItem.init(color: .blue, value: 0.2,title: "bluecolor")
        let item3 = ShinePieItem.init(color: .green, value: 0.3,title: "greencolor")
        
        let pie = ShinePieChart.init(frame: CGRect.init(x: 0, y: 100, width: 300, height: 200), items: [item1,item2,item3])
        
        pie.backgroundColor = UIColor.gray
        
        pie.ringRadius = 20
        
        pie.startAngle = 0.2
        
        pie.font = UIFont.systemFont(ofSize: 12)
        
        pie.duration = 3
        
        view.addSubview(pie)
    }

    deinit {
        print("deinit")
    }


}

