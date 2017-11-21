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
        
       
    }
    
    @IBAction func pieClick(_ sender: UIButton) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func lineClick(_ sender: UIButton) {
        let vc = DetailViewController()
        vc.style = .line
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func bar(_ sender: UIButton) {
        let vc = DetailViewController()
        vc.style = .bar
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
   


}

