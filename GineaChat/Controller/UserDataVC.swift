//
//  UserDataVC.swift
//  GineaChat
//
//  Created by Bruce Bookman on 8/14/18.
//  Copyright © 2018 Bruce Bookman. All rights reserved.
//

import UIKit

class UserDataVC: UIViewController {

    var user: User?
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    let dataService: DataService = DataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let segueToVC = segue.destination as? MessageTableViewController {
            
            segueToVC.appUser = self.user
        }
    }

    @IBAction func didTapSave(_ sender: UIButton) {
        
        guard
            let firstNameText = txtFirstName.text,
            let lastNameText = txtLastName.text,
            let emailText = txtEmail.text
            else {
                print("ERROR: First name, last name, or email address is nil")
                return
        }
        
        self.user = User(firstName: firstNameText, lastName: lastNameText, emailAddress: emailText )

        dataService.writeUser(user: user!)
        
        performSegue(withIdentifier: "backToMessageVC", sender: self)
        
        
    }//didTapSave
}









