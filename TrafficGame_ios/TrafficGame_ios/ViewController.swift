//
//  ViewController.swift
//  TrafficGame_ios
//
//  Created by 周福 on 2020/2/13.
//  Copyright © 2020 zf.org.csu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        // Do any additional setup after loading the view.
    }
    


}

extension ViewController:UITabBarDelegate{
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "Myhome" {
            print("success")
        }
    }
}

