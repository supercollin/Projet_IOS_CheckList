//
//  DataModel.swift
//  CheckLists
//
//  Created by iem on 05/04/2018.
//  Copyright © 2018 iem. All rights reserved.
//

import Foundation

let dataModel = DataModel()

class DataModel {
    
    var listCheckList : Array<CheckList>
    
    init() {
        listCheckList = Array<CheckList>()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveCheckList),
            name: .UIApplicationDidEnterBackground,
            object: nil)
    }
    
    func setListCheckList(list : Array<CheckList>){
        self.listCheckList = list
    }
    
    @objc func saveCheckList(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(listCheckList)
            try data.write(to: AllListViewController.dataFileUrl)
        } catch {
            print("error during encoding")
        }
    }
    
    func loadCheckList() -> [CheckList]{
        let decoder = JSONDecoder()
        do {
            let data = try String(contentsOf: AllListViewController.dataFileUrl, encoding: .utf8).data(using: .utf8)
            listCheckList = try decoder.decode([CheckList].self, from: data!)
        } catch {
            print("error during saving")
        }
        return listCheckList
    }
    
}
