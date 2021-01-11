//
//  ResultTableViewController.swift
//  HongKong_banknote_Classifier
//
//  Created by Hok yung Chau on 4/5/2020.
//  Copyright © 2020 Hok yung Chau. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    var results :[String] = [];
    var text : String = ""
    var loadText : [String] = ["NAME", "NNNN" ];

    override func viewDidLoad() {
        super.viewDidLoad()
 
        print(results)

    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = results[indexPath.row]
        
        return cell
    }
   
}
