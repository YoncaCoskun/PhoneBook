//
//  EnteryViewController.swift
//  PhoneBook
//
//  Created by Yonca Coskun on 23.01.2017.
//  Copyright © 2017 PoncikApps. All rights reserved.
//

import UIKit
import RealmSwift

class EnteryViewController: UIViewController {

    //@IBOutlet weak var txtContactName: UITextField!
    //@IBOutlet weak var txtContactTelephoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func actionSaveData(_ sender: Any) {
        //saveContacts()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
  /*  func saveContacts(){
        
    let newContact = ContactItem()
        newContact.Name = txtContactName.text!
        newContact.PhoneNumber = txtContactTelephoneNumber.text!
        
        do{
            let realm = try Realm()
            try realm.write { ()->Void in
              try  realm.add(newContact)
                print("Contact Save")
            }
        
        }
        catch{
        
        }
        
        
    }*/

    
}
