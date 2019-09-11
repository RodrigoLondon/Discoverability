//
//  UserController.swift
//  Discoverability
//
//  Created by Lewis Jones on 10/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    var users: [User] = []
    
    let nameFormatter: PersonNameComponentsFormatter = {
        let formatter = PersonNameComponentsFormatter()
        formatter.style = .long
        return formatter
        
    }()
    
    func checkForExistingUserWith(email: String, completion: @escaping (User?) -> Void) {
        
        CloudKitManager.shared.fetchUserIdentityWith(email: email) { (userIdentity, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let userIdentity = userIdentity,
            let nameComponents = userIdentity.nameComponents else { completion(nil); return }
            
            let name = self.nameFormatter.string(from: nameComponents)
            
            let user = User(name: name)
            
            completion(user)
            
        }
    }
    
    func fetchAllDiscoverableUsers(completion: @escaping () -> Void) {
        CloudKitManager.shared.fetchAlllDiscoverableUserIdentities { (userIdentities, error) in
            
            if let error = error {
                print(error.localizedDescription)
                
                
                let nameComponentsArray = userIdentities.compactMap({ $0.nameComponents })
                
                let formattedNames = nameComponentsArray.map({ self.nameFormatter.string(from: $0) })
                
                let users = formattedNames.map({ User(name: $0) })
                
                self.users = users
                
                completion()

            }
        }
    }
    
}
