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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let checkListItem = CheckListItem(text: "Finir le cours d’iOS")
        let checkListItem2 = CheckListItem(text:"Mettre à jour XCode", checked:true)
        listcheckListItem = [checkListItem,checkListItem2]
        
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listcheckListItem[indexPath.row].toggleChecked()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        listcheckListItem.remove(at: indexPath.row)
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
        if(segue.identifier == "addItem"){
            let addItemVC = segue.destination as! UINavigationController
            let destination = addItemVC.topViewController as! AddItemViewController
            destination.delegate = self
        }
        if(segue.identifier == "editItem"){
            let addItemVC = segue.destination as! UINavigationController
            let destination = addItemVC.topViewController as! AddItemViewController
            destination.delegate = self
        }
    }
    
}

extension CheckListViewController: AddItemViewDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemViewController){
        self.dismiss(animated: true)
    }
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem){
         listcheckListItem.append(item)
         let indexPath = IndexPath(row: listcheckListItem.count-1, section: 0)
         tableView.insertRows(at: [indexPath] , with: .automatic)
         self.dismiss(animated: true)
    }
}
