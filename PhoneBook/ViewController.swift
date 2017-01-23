//
//  ViewController.swift
//  PhoneBook
//
//  Created by Yonca Coskun on 20.01.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.setupUI()
    }

    func setupUI() {
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    //Data Source delegation
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath.row) ")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let identifier:String = "myCell"

        var cell = tableview.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle , reuseIdentifier: identifier)
            
        }
        cell?.textLabel?.text = "Row \(indexPath.row)"
        cell?.detailTextLabel?.text = "\(NSDate())"
        return cell!
        
    }

    //sütun aralarını genişletme
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70
    }
    
    
 /*   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        // custom view for header. will be adjusted to default or specified header height
        let myHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableview.frame.width, height: 80))
        myHeader.backgroundColor = UIColor.yellow
        return myHeader
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        // custom view for footer. will be adjusted to default or specified footer height
        let myHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableview.frame.width, height: 80))
        myHeader.backgroundColor = UIColor.purple
        return myHeader
    }
 */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

