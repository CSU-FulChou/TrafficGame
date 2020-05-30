//
//  MyVC.swift
//  TrafficGame_ios
//
//  Created by 周福 on 2020/2/13.
//  Copyright © 2020 zf.org.csu. All rights reserved.
//

import UIKit

class MyVC: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var titleLable: UILabel!
    
    override func viewDidLoad() {
        
        let navigationView = UIView(frame: CGRect(x: 0, y: 0, width: 340, height: 30))
        
        
        super.viewDidLoad()
       
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        titleLable.text = "你好，小蜜蜂"
        //
        titleLable.sizeToFit()
        
        self.navigationController?.navigationItem.titleView = navigationView
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MyVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "个人信息"
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
