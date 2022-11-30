//
//  Item.swift
//  Quiz
//
//  Created by sunny on 2022/11/25.
//

import UIKit

class Item: Equatable, Codable {
    var question: String;
    var selection: String?;
    var answer: String;
    let dateCreated: Date;
    let itemKey: String
    
    init(question: String, selection: String?, answer: String) {
        self.question = question;
        self.selection = selection;
        self.answer = answer;
        self.dateCreated = Date();
        self.itemKey = UUID().uuidString
        print(self.itemKey)
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.question == rhs.question && lhs.selection == rhs.selection && lhs.answer == rhs.answer;
    }
}
