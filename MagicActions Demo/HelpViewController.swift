//
//  HelpViewController.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 25/11/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit
import MagicActions

class HelpViewController: UITableViewController {

    @IBAction func doneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MagicActions.actions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actionCell")!
        let action = Array(MagicActions.actions)[indexPath.row]
        cell.textLabel?.text = action.title + " - " + action.description
        cell.detailTextLabel?.text = action.trigger
        return cell
    }
    
}
