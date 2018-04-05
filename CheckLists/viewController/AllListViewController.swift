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
    private var indexPathEdit : IndexPath!
    
    class var documentDirectory : URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    class var dataFileUrl : URL{
        return documentDirectory.appendingPathComponent("CheckList").appendingPathExtension("json")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCheckList = Array<CheckList>()
        
        listCheckList = dataModel.loadCheckList()
        
        /*/**** liste 1 ****/
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
        listCheckList.append(checkList)*/
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        listCheckList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, let checkListViewController = segue.destination as? CheckListViewController{
            
            if let destination = checkListViewController as? CheckListViewController {
            
                if (identifier == "goToItemList") {
                    let cell = sender as? UITableViewCell
                    let indexPath = tableView.indexPath(for: cell!)
                    let row = indexPath?.row
                    destination.list = listCheckList[row!]
                }
            }
                
        }else if let identifier = segue.identifier,
            let navigationController = segue.destination as? UINavigationController,
            let destination = navigationController.topViewController as? ListDetailViewController {
    
            if identifier == "editItemList", let cell = sender as? UITableViewCell {
                destination.delegate = self
                let indexPath = tableView.indexPath(for: cell)
                indexPathEdit = indexPath
                let item = listCheckList[indexPath!.row]
                destination.itemToEdit = item
            }else if identifier == "addItem" {
                destination.delegate = self
            }
        }
    }
    
}


extension AllListViewController : ListDetailViewControllerDelegate{
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController){
        self.dismiss(animated: true)
    }
    
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList){
        print("delegate add")
        listCheckList.append(item)
        let indexPath = IndexPath(row: listCheckList.count-1, section: 0)
        tableView.insertRows(at: [indexPath] , with: .automatic)
        self.dismiss(animated: true)
        dataModel.setListCheckList(list: listCheckList)
    }
    
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList){
        print("delegate edit")
        let cell = tableView.cellForRow(at: indexPathEdit) as! UITableViewCell
        cell.textLabel?.text = item.name
        listCheckList[indexPathEdit.row].name = item.name
        self.dismiss(animated: true)
        dataModel.setListCheckList(list: listCheckList)
    }
}

