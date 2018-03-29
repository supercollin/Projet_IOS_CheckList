//
//  AllListViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    private var listCheckList : Array<CheckList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCheckList = Array<CheckList>()
        
        /**** liste 1 ****/
        var item1 = CheckListItem(text: "l1 item1")
        var item2 = CheckListItem(text: "l1 item2")
        var checkListItem = Array<CheckListItem>()
        checkListItem.append(item1)
        checkListItem.append(item2)
        
        var checkList = CheckList(name: "liste1", items: checkListItem)
        listCheckList.append(checkList)
        
        /**** liste 2 ****/
        item1 = CheckListItem(text: "l2 item1")
        item2 = CheckListItem(text: "l2 item2")
        checkListItem = Array<CheckListItem>()
        checkListItem.append(item1)
        checkListItem.append(item2)
        
        checkList = CheckList(name: "liste2", items: checkListItem)
        listCheckList.append(checkList)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listCheckList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckList", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = listCheckList[row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, let checkListViewController = segue.destination as? CheckListViewController,
            let destination = checkListViewController as? CheckListViewController {//test
            
            if (identifier == "goToItemList") {
                let cell = sender as? UITableViewCell
                let indexPath = tableView.indexPath(for: cell!)
                let row = indexPath?.row
                destination.list = listCheckList[row!]
            }
        }
    }

}
