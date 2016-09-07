//
//  ViewController.swift
//  表单联动colleview
//
//  Created by lotawei on 16/9/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       tableView.separatorStyle = .None
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row==0 {
            let    atable = TableViewController()
            atable.title = "tableview"
            navigationController?.pushViewController(atable, animated: true)
        }
        else{
            let  colle = CollectionViewController()
            colle.title = "collectionview"
            navigationController?.pushViewController(colle, animated: true)
        }
    }


}

