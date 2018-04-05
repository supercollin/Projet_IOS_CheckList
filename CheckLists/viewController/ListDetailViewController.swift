//
//  ListDetailViewController.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var textfield: UITextField!
    
    var delegate : ListDetailViewControllerDelegate?
    var itemToEdit : CheckList?
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.ListDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: Any) {
        let listItems = Array<CheckListItem>()
        let item = CheckList(name: textfield.text!, items: listItems)
        
        if(itemToEdit != nil){
            item.items = listItems
            delegate?.ListDetailViewController(self, didFinishEditingItem: item)
        }else{
            delegate?.ListDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    @IBAction func testIfIsEmpty(_ textField: UITextField) {
        self.doneButton.isEnabled = !(textField.text?.isEmpty)!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textfield.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil){
            textfield.text = itemToEdit?.name
            self.doneButton.isEnabled = false
        }
    }

}

protocol ListDetailViewControllerDelegate : class {
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList)
}
