//
//  MessageTableViewController.swift
//  GineaChat
//nb
//  Created by Bruce Bookman on 8/2/18.
//  Copyright © 2018 Bruce Bookman. All rights reserved.
//

import UIKit

class MessageTableViewController: UITableViewController {
    
    var appUser: User?
    var messages: [Message]?
    
    @IBOutlet weak var sendText: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let dataService: DataService = DataService()
        
        if let user = appUser {
            
            dataService.readMessage(user: user) { (messages) in
                
                if messages.isEmpty {
                    print("No messages")
                } else {
                    
                    self.messages = messages
                    self.tableView.reloadData()
                }
                
            }
            
        } else {
            print("User is nill")
        }
    }
    
    
    @IBAction func didTapSend(_ sender: UIButton) {
        
        guard let user = appUser else {
            print("No user found")
            return
        }
        
        let message: Message = Message(messageText: self.sendText.text ?? "", senderEmail: user.emailAddress)
        
        let dataService: DataService = DataService()
        dataService.writeMessage(message: message)
        self.sendText.text = ""
        
        
        
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let messages = self.messages else {
            print("Warning, messages is nil")
            return 0
        }
        
        return messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        guard let messages = self.messages else {
            print("Messages is nil")
            return cell
        }
        
        let message = messages[indexPath.row]
        cell.displayMessage(message: message)

        return cell
    }
    

    

}
