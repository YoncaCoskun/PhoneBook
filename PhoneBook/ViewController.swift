//
//  ViewController.swift
//  PhoneBook
//
//  Created by Yonca Coskun on 20.01.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableview: UITableView!
    
    //dataların tutuldugu yer
    var datasource:Results<ContactItem>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTheTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.setupUI()
       reloadTheTable()
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }

    func reloadTheTable(){
        do{
            let realm = try Realm()
            datasource = realm.objects(ContactItem)
            tableview?.reloadData()
    
        }
        catch{
        }
    
        
        
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
        return datasource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let identifier:String = "myCell"

        var cell = tableview.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle , reuseIdentifier: identifier)
            
        }
        
        let currentContactInfo = datasource[indexPath.row]
        cell?.textLabel?.text = currentContactInfo.Name
        cell?.detailTextLabel?.text = currentContactInfo.PhoneNumber
        return cell!
        
    }

    //sütun aralarını genişletme
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
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
    
    @IBAction func actionGoToEnteryVC(_ sender: Any) {
        performSegue(withIdentifier: "goToEnteryVC"  , sender: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

