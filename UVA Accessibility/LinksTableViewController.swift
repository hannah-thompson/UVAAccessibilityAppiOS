//
//  LinksTableViewController.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/24/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

import UIKit

class LinksTableViewController: UITableViewController {

    var currentResourceItem: ResourceItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // will return as a count
        return (currentResourceItem?.titles.count)!
    }

    // Override to show what each cell should have in it based on the note in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LinksTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LinksTableViewCell
        
        // Fetches the appropriate note for the data source layout.
        let linkItem = currentResourceItem?.titles[indexPath.row]
        
        cell.LinkTitleNameLabel.text = linkItem
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // define what to do if clicked
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath){
        
        if let url = URL(string: (currentResourceItem?.links[indexPath.row])!) {
            UIApplication.shared.open(url, options: [:])
        }
    }

}
