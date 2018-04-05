//
//  IconPickerViewController.swift
//  CheckLists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation
import UIKit

class IconPickerViewController : UITableViewController{
    
    var iconList = [IconAsset.Appointments, IconAsset.Birthdays, IconAsset.Chores,
                    IconAsset.Drinks, IconAsset.Folder, IconAsset.Groceries,
                    IconAsset.Inbox, IconAsset.Photos, IconAsset.Trips,
                    IconAsset.NoIcon]
    
    var delegate : IconPickerViewControllerDelegate?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return iconList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Icon", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = iconList[row].rawValue
        cell.imageView?.image = iconList[row].image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.finishSelectIcon(withIcon: iconList[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}

protocol IconPickerViewControllerDelegate: class {
    func finishSelectIcon(withIcon icon : IconAsset)
}
