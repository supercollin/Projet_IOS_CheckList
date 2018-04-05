//
//  ViewController.swift
//  CheckLists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    private var listcheckListItem: Array<CheckListItem>!
    var list : CheckList!
    private var indexPathEdit : IndexPath!
    var delegateUnchecked : CheckListViewControllerDelegateUncheckedItems?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = list.name
        listcheckListItem = list.items
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listcheckListItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath) as! CheckListItemCell
        let row = indexPath.row
        cell.textCell.text = listcheckListItem[row].text
        
        if(listcheckListItem[row].checked){
            cell.checkMark.isHidden = false
        }else{
            cell.checkMark.isHidden = true
        }
        cell.checkMark.textColor = view.tintColor
        delegateUnchecked?.reloadTableView()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listcheckListItem[indexPath.row].toggleChecked()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        list.items = listcheckListItem
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        listcheckListItem.remove(at: indexPath.row)
        list.items = listcheckListItem
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: CheckListItem){
        if(item.checked){
            cell.accessoryType = .none
        }else{
            cell.accessoryType = .checkmark
        }
    }
    
    func configureText(for cell: UITableViewCell, withItem item: CheckListItem){
        cell.textLabel?.text = item.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, let navigationViewController = segue.destination as? UINavigationController,
            let destination = navigationViewController.topViewController as? ItemDetailViewController {//test
            
            if (identifier == "addItem") {
                destination.delegate = self
            } else if identifier == "editItem",
                let cell = sender as? UITableViewCell {
                destination.delegate = self
                let indexPath = tableView.indexPath(for: cell)
                indexPathEdit = indexPath
                let item = listcheckListItem[indexPath!.row]
                destination.itemToEdit = item
            }
        }
    }
    
}

extension CheckListViewController: ItemDetailViewControllerDelegate{
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController){
        self.dismiss(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem){
         listcheckListItem.append(item)
         list.items = listcheckListItem
         let indexPath = IndexPath(row: listcheckListItem.count-1, section: 0)
         tableView.insertRows(at: [indexPath] , with: .automatic)
         self.dismiss(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem){
        let cell = tableView.cellForRow(at: indexPathEdit) as! CheckListItemCell
        cell.textCell.text = item.text
        listcheckListItem[indexPathEdit.row].text = item.text
        list.items = listcheckListItem
        self.dismiss(animated: true)
    }
}

protocol CheckListViewControllerDelegateUncheckedItems : class {
    func reloadTableView()
}

