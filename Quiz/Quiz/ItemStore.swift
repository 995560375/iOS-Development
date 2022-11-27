//
//  ItemStore.swift
//  Quiz
//
//  Created by sunny on 2022/11/25.
//

import UIKit

class ItemStore {
    var allItems = [Item]();
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(question: "123", selection: "123", answer: "123");
        allItems.append(newItem);
        return newItem;
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index);
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return;
        }
        let movedItem = allItems[fromIndex];
        allItems.remove(at: fromIndex);
        allItems.insert(movedItem, at: toIndex);
    }
    
    init() {
        for _ in 0..<5 {
            createItem();
        }
    }
}
