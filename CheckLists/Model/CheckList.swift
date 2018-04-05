//
//  CheckList.swift
//  CheckLists
//
//  Created by iem on 29/03/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

class CheckList : Codable  {
    
    var name = ""
    var items: Array<CheckListItem>
    
    var uncheckedItemsCount : Int{
        get{
            var nbUnchecked = 0
            for item in items{
                if(!item.checked){
                    nbUnchecked = nbUnchecked + 1
                }
            }
            return nbUnchecked
        }
    }
    
    
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
