//
//  UserSearchViewController.swift
//  Discoverability
//
//  Created by Lewis Jones on 12/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {

    @IBOutlet weak var userExistLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func serachButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text else { return }
        
        UserController.shared.checkForExistingUserWith(email: email) { (user) in
            
            
            var labelText = ""
            
            if let user = user {
                // The user exists and is discoverable in the current user's contact list.
                
                labelText = "\(user.name) has the app, has allowed users discoverability, and is in your contacts list"
                
            } else {
                // The users didn't accept discoverability and/or they aren't in the current user's contact list.
            
            labelText = "User with email \(email) didn't accept discoverability and/or they aren't in the current user's contact list."
            
            }
            DispatchQueue.main.async {
                 self.userExistLabel.text = labelText
            }
        }
    }
}
