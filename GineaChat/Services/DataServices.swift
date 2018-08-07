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
        ] as [String:Any]
        
        userDataReference.childByAutoId().setValue(data)
        print("--------------- WROTE USER ------------")
        print("Wrote user \(user.firstName) \(user.lastName) \(user.emailAddress)" )
        print("----------------------------------------")
    }
    
    func writeMessage(message: Message){
        let data = ["messageText": message.messageText as Any,
                    "email": message.senderEmail as Any
            ] as [String:Any]
        
        messageDataReference.childByAutoId().setValue(data)
        print("--------------- WROTE MESSAGE ------------")
        print("Write message \(String(describing: message.messageText)) from \(String(describing: message.senderEmail))")
        print("----------------------------------------")
        
    }

    func readMessage(user: User, completion: @escaping  (Message?) -> Void)  {
        
        var returnObject: Message = Message(messageText: nil, senderEmail: nil)

        self.messageDataReference.observeSingleEvent(of: .value) { (snapshot) in
            guard let data = snapshot.value as? [String:Any] else {
                print("bad data")
                completion(nil)
                return
            }
            
            if data["messageText"] != nil  && data["email"] != nil {
                returnObject.messageText = data["messageText"] as? String
                returnObject.senderEmail = data["email"] as? String
                print("Got message text: \(String(describing: returnObject.messageText))")
                print("Got sender email: \(String(describing: returnObject.senderEmail))")
                
            }
            print("---------------  RETURNING ---------------  ")
            print("returnObject: \(String(describing: returnObject))")
            completion(returnObject)

        }//observe
        
    }
    
    /*
     func GetUsername(uid:String , completion: (String) -> ()) {
     firebase.child("Users").child(uid).observeSingleEventOfType(.Value) { (snapshot:FIRDataSnapshot) in
     if let username = snapshot.value!["Username"] as? String
     completion(username)
     }
     else {
     completion("")
     }
     }

 */
    
    
    
}
