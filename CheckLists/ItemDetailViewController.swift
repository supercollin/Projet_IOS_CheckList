//
//  AddItemViewControllerTableViewController.swift
//  CheckLists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var delegate : ItemDetailViewControllerDelegate?
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
            delegate?.ItemDetailViewController(self, didFinishEditingItem: item)
        }else{
            delegate?.ItemDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    @IBAction func cancel() {
        delegate?.ItemDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    @IBAction func testIfIsEmpty(_ textField: UITextField) {
        self.doneButton.isEnabled = !(textField.text?.isEmpty)!
    }
    
}
protocol ItemDetailViewControllerDelegate : class {
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditingItem item: CheckListItem)
}
