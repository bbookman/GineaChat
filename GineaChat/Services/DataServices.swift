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


    func readMessage(completion: @escaping ([Message])-> Void){
        
        var foundMessages: [Message] = []
        
        self.messageDataReference.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let data = dataSnapshot.value as? [String: [String: String]] else {
                print("Bad Data")
                return
            }
            
            for (_, message) in data  {
                guard let sender = message["email"], let content = message["messageText"] else {
                    
                    print("Bad email or message")
                    return
                    
                }
              
          
                foundMessages.append(Message(messageText: content, senderEmail: sender))
          
                
            }//for
            completion(foundMessages)
            
        }//self.messageDataReference
        
    }//readMessage
    


    
}
