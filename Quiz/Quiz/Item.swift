//
//  Item.swift
//  Quiz
//
//  Created by sunny on 2022/11/25.
//

import UIKit

class Item: Equatable {
    var question: String;
    var selection: String?;
    var answer: String;
    let dateCreated: Date;
    
    init(question: String, selection: String?, answer: String) {
        self.question = question;
        self.selection = selection;
        self.answer = answer;
        self.dateCreated = Date();
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.question == rhs.question && lhs.selection == rhs.selection && lhs.answer == rhs.answer;
    }
}
