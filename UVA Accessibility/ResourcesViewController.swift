//
//  ResourcesViewController.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/11/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ResourcesViewController: UITableViewController {

    var resourceItems = [ResourceItem]()
    var resourceItem = ResourceItem(name: "", titles: [""], links: [""])
    var index: Int = 0
    
    var ref: DatabaseReference!
    
    //completion: @escaping ([ResourceItem]) -> Void
    func loadFirebaseData() {
        
        ref = Database.database().reference()
        
        
        // FIGURE OUT WHY THIS UNABLE TO ACTUALLY UPDATE THE GLOBAL VALUE
        // LOOK INTO WHAT IT MEANS TO BE "IN CLOSURE"
        // add completion handler where you can send back resource items ??
        // changed from observeSingleEvent to observe
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let items = snapshot.value as? NSDictionary
            var itemsToSend = [ResourceItem]()
            for item in items!{
                // name of it's children
                var titles: [String] = []
                var links: [String] = []
                for thing in (item.value as! NSDictionary){
                    titles.append(thing.key as! String)
                    links.append(thing.value as! String)
                }
                let newItem = ResourceItem(name: item.key as! String, titles: titles, links: links)
                itemsToSend += [newItem]
            }
            //completion(itemsToSend)
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let items = snapshot.value as? NSDictionary
            var itemsToSend = [ResourceItem]()
            for item in items!{
                // name of it's children
                var titles: [String] = []
                var links: [String] = []
                for thing in (item.value as! NSDictionary){
                    titles.append(thing.key as! String)
                    links.append(thing.value as! String)
                }
                let newItem = ResourceItem(name: item.key as! String, titles: titles, links: links)
                itemsToSend += [newItem]
            }
            self.resourceItems = itemsToSend
            self.resourceItems.sort()
            self.tableView.reloadData()
            })
        }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TableView Functions
    // Override to show how many lists there should be
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Override to show how many items are in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourceItems.count
    }
    
    // Override to show what each cell should have in it based on the note in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ResourceTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ResourceTableViewCell
        
        // Fetches the appropriate note for the data source layout.
        let resourceItem = resourceItems[indexPath.row]
        
        cell.resourceItemNameLabel.text = resourceItem.name
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // add in segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "linksSegue" {
            let destinationVC = segue.destination as! LinksTableViewController
            index = (tableView.indexPathForSelectedRow?.row)!
            destinationVC.currentResourceItem = self.resourceItems[index]
        }
    }
    

}
