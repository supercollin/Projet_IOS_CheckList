//
//  AddItemViewControllerTableViewController.swift
//  CheckLists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var delegate : AddItemViewDelegate?
    var itemToEdit : CheckListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil){
            textField.text = itemToEdit?.text
            self.doneButton.isEnabled = false
        }
    }
    
    @IBAction func done() {
        let item = CheckListItem(text: textField.text!)
        
        if(itemToEdit != nil){
            delegate?.addItemViewController(self, didFinishEditingItem: item)
        }else{
            delegate?.addItemViewController(self, didFinishAddingItem: item)
        }
    }
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func testIfIsEmpty(_ textField: UITextField) {
        self.doneButton.isEnabled = !(textField.text?.isEmpty)!
    }
    
    
    
}
protocol AddItemViewDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem)
}
