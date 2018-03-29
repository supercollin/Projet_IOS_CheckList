//
//  CheckListItem.swift
//  CheckLists
//
//  Created by iem on 08/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation


class CheckListItem : Codable{
    var text = ""
    var checked = false
    
    init(text: String) {
        self.text = text
    }
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked() {
        self.checked = !self.checked
    }
}
