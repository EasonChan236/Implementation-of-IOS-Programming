//
//  ItemStore.swift
//  Homepwner
//
//  Created by EasonChan on 12/27/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class ItemStore{
    var allItems = [Item]()
    
    init(){
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path!) as? [Item] {
            allItems += archivedItems
        }
    }
    
    let itemArchiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("item.archive") as NSURL
    }()
    // MARk: -
    func saveChanges() -> Bool{
        print("Saving items to : \(itemArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path!)
    }
    func createItem () -> Item{
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item:Item){
        if let index = allItems.index(of:item){
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        
        //get reference to object being moved so you can reinsert item
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem,at:toIndex)
    }
}
