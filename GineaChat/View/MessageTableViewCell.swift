//
//  MessageTableViewCell.swift
//  GineaChat
//
//  Created by Bruce Bookman on 8/16/18.
//  Copyright © 2018 Bruce Bookman. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

  
    @IBOutlet weak var lblSenderID: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    
    func displayMessage(message: Message){
        self.txtMessage.text = message.messageText
        self.lblSenderID.text = message.senderEmail
    }
    
 
    
    
}
