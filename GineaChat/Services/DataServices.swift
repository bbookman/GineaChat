//
//  DataServices.swift
//  GineaChat
//
//  Created by Bruce Bookman on 8/2/18.
//  Copyright © 2018 Bruce Bookman. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct DataService {
    
    let userDataReference = Database.database().reference().child("users")
    let messageDataReference = Database.database().reference().child("messages")

    func writeUser(user: User){
        

        let data = ["firstname": user.firstName,
                    "lastname": user.lastName,
                    "email": user.emailAddress
        ] as [String:String]
        
        userDataReference.childByAutoId().setValue(data)
        print("--------------- WROTE USER ------------")
        print("Wrote user \(user.firstName) \(user.lastName) \(user.emailAddress)" )
        print("----------------------------------------")
    }
    
    func writeMessage(message: Message){
        let data = ["messageText": message.messageText,
                  "email": message.senderEmail
            ] as [String:String]
        
        messageDataReference.childByAutoId().setValue(data)
        print("--------------- WROTE MESSAGE ------------")
        print("Write message \(message.messageText) from \(message.senderEmail)")
        print("----------------------------------------")
        
    }

    func readMessage(user: User, completion: @escaping  (Message?) -> Void)  {
        self.messageDataReference.observe(.value) { (snapshot) in
            guard
                let data = snapshot.value as? [String:String],
                let messageText = data["messageText"],
                let senderEmail = data["email"]
                
                else {
                    print("Error - Data incomplete")
                    completion(nil)
                    return
            }//else guard
            var message: Message?
            message?.messageText = messageText
            message?.senderEmail = senderEmail
            print("Message from readMessage: \(String(describing :message))")
            completion(message)
            
        }
        
    }
    
    
    
    
}
