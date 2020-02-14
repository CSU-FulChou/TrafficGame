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
        
        if item.title == "my" {
            
            print("success")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myViewController = storyboard.instantiateViewController(withIdentifier: "MyVC")
            navigationController?.pushViewController(myViewController, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil)
            
        }
    }
}

