//
//  ShowResultVC.swift
//  HongKong_banknote_Classifier
//
//  Created by Hok yung Chau on 5/5/2020.
//  Copyright © 2020 Hok yung Chau. All rights reserved.
//

import UIKit

class ShowResultVC: UITableViewController {
    var results : [String]? = nil;

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        if results?.count != nil {
            return results!.count

        }else{
             return 0
        }
       
    }
    

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if results.count > 0{
            let cell = UITableViewCell();
                cell.textLabel?.text = results?[indexPath.row]
                return cell
                
//        }else{
//            return nil
//        }
    }
    
}
