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
        print("Wrote user \(user.firstName) \(user.lastName) \(user.emailAddress)" )
    }
    
    func writeMessage(message: Message){
        let data = ["messageText": message.messageText,
                  "email": message.senderEmail
            ] as [String:String]
        
        messageDataReference.childByAutoId().setValue(data)
        print("Write message \(message.messageText) from \(message.senderEmail)")
        
    }

    func readMessage(user: User, completion: @escaping (Message)->()){
        var messageToReturn:Message?
        
        self.messageDataReference.observeSingleEvent(of: .value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot {
                    if let data = snap.value as? [String:String] {
                        
                        
                        print("Data \(String(describing: data))")
                        
                        guard let messageText = data["messageText"] else {
                            print("Could not get message text")
                            return
                        }
                        print("messageText: \(messageText)")
                        
                        guard let email = data["email"] else {
                            print("Could not get email")
                            return
                        }
                        
                        print("Email: \(email)")
                        
                        if email != user.emailAddress {
                            
                            messageToReturn?.messageText = messageText
                            messageToReturn?.senderEmail = email
                        } else {
                            print("Message is from self")
                            return  
                        }
                    }//let data
                }//for snap
                if messageToReturn != nil {
                    print("\(String(describing: messageToReturn))")
                    completion(messageToReturn!)
                }
            }// let snapshot
        }//ref
        
    }
    

    
}
