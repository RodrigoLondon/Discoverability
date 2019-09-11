//
//  UsersTableViewController.swift
//  Discoverability
//
//  Created by Lewis Jones on 12/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        
        UserController.shared.fetchAllDiscoverableUsers {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserController.shared.users.count
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = UserController.shared.users[indexPath.row]
        cell.textLabel?.text = user.name
        
        return cell
      }
    }

