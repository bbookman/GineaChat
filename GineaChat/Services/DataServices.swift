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
    }
    
    func writeMessage(message: Message){
        let data = ["messageText": message.messageText,
                  "email": message.senderEmail
            ] as [String:String]
        
        messageDataReference.childByAutoId().setValue(data)
        
    }
    
    func readMessage(user: User, completion: @escaping (Message?)-> Void){
        var returnMessage: Message?
        self.messageDataReference.observeSingleEvent(of: .value) { (dataSnapshot) in
            if let data = dataSnapshot.children.allObjects as? [DataSnapshot]{
                print("dataSnapshot is not nil")
                
                for info in data {
                    print("Hi we are inside the info loop")

                    if let snap = dataSnapshot.value as? [String:String] {
                        
                        print("dataSnapshot.value is not nil and [String:String]")
                        
                        if snap["email"] != nil && snap["messageText"] != nil {
                            
                            returnMessage?.messageText = snap["messageText"]!
                            returnMessage?.senderEmail = snap["email"]!
                            
                            
                            print("Sender : \(returnMessage?.senderEmail)")
                            print("Message : \(returnMessage?.messageText)")
                            
                        }//if snap
                        
                        
                    }//if let snao
        
                }//for info in data
            }//if let data
        }//self.messageDataReference
    }//readMessage
        
        
    /*
         [Snap (-LJ_JkJCCMhIlb-yugEb) {
            email = "fdssdfdsafds@bbb.com";
            messageText = "How are you today?";
         
         }, Snap (-LJ_KKKeD03cHqK6yrw5) {
            email = "fdssdfdsafds@bbb.com";
            messageText = "How are you today?";
         }]

 */
    
        
        
        


    
}
