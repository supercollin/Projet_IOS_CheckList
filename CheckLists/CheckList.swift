//
//  CheckList.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class CheckList {
    
    var name = ""
    var items: Array<CheckListItem>
    
    init(name: String, items : Array<CheckListItem>?) {
        self.name = name
        if(items == nil){
            self.items = Array<CheckListItem>()
        }else{
            self.items = items!
        }
    }
    
    func addCheckListItem( checkListItem : CheckListItem){
        self.items.append(checkListItem)
    }
    
}
