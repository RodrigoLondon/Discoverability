//
//  CloudKitManager.swift
//  Discoverability
//
//  Created by Lewis Jones on 10/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation
import CloudKit


class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    func requestDiscoverabilityAuthorization(completion: @escaping (CKContainer_Application_PermissionStatus, Error?) -> Void) {
        
        CKContainer.default().status(forApplicationPermission: .userDiscoverability) { (permissionStatus, error) in

            guard permissionStatus != .granted else { completion(.granted, error); return }
            
                CKContainer.default().requestApplicationPermission(.userDiscoverability, completionHandler: completion)
        }
     }
    
    func fetchUserIdentityWith(email: String, completion: @escaping (CKUserIdentity?, Error?) -> Void) {
        CKContainer.default().discoverUserIdentity(withEmailAddress: email, completionHandler: completion)
        
    }
    
    func fetchAlllDiscoverableUserIdentities(completion: @escaping ([CKUserIdentity], Error?) -> Void) {
        
        let discoverIdentitiesOp = CKDiscoverAllUserIdentitiesOperation()
        
        var discoveredIdentities: [CKUserIdentity] = []
        
        discoverIdentitiesOp.userIdentityDiscoveredBlock = { identity in
            discoveredIdentities.append(identity)
        }
        discoverIdentitiesOp.discoverAllUserIdentitiesCompletionBlock = { error in
            completion(discoveredIdentities, error)
        }
        CKContainer.default().add(discoverIdentitiesOp)
    }
    
 }
