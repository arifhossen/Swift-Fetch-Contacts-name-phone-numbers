//
//  ViewController.swift
//  ReadContacts
//
//  Created by MAC on 31/7/20.
//  Copyright © 2020 Arif Hossen. All rights reserved.

/*
 
    Step 1: Create New Project name: readcontacts
    Step 2: Set Contact Read Permission in Info.plist example: Privacy - Contacts Usage Description : String -> Read User Contacts for send notification
    Step 3: UI Design & Create Tableview and TableView Cell
    Step 4: Read Contact by programmetically and contacts set to tableview
    Step 5: Run Project
 
 */


import UIKit
import Contacts

struct ContactModel: Codable {
    var full_name: String
    var phone_number: String
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var contactLists = [ContactModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Call Read Contacts Function
        self.fetchContactsData()      
        
        
    }
    
    private func fetchContactsData() {
        print("Attempting to fetch contacts contact list")
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access permission:", err)
                return
            }
            
            if granted {
                print("Access granted permission")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do {
                    request.sortOrder = CNContactSortOrder.userDefault
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumerating) in
                        
                        let phone_number = contact.phoneNumbers.first?.value.stringValue ?? ""
                        if phone_number != ""{
                            
                            let full_name = contact.givenName + " " + contact.familyName
                            let phone_number = contact.phoneNumbers.first?.value.stringValue ?? ""
                            let formated_phone_number = phone_number.replacingOccurrences(of: " ", with: "")
                            
                            let contact_object = ContactModel(full_name: full_name, phone_number: formated_phone_number)
                            self.contactLists.append(contact_object)
                            
                        }
                    })
                    
                    self.tableView.reloadData()
                    
                    
                    
                } catch let err {
                    print("Failed to enumerate contacts:", err)
                }
                
            } else {
                print("Access denied..")
            }
        }
    }
    
    // MARK: - Table view data source
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var message:String = "All Contacts"
        return message
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactLists.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var customHeight = 0 as! Int
        customHeight = 20
        return CGFloat(customHeight)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var customHeight = 100 as! Int
        return CGFloat(customHeight)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowData = self.contactLists[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblCell", for: indexPath) as! ContactTableViewCell
        
        cell.nameOutlet.text = rowData.full_name
        cell.phoneOutlet.text = rowData.phone_number
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}

