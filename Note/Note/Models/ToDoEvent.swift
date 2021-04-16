//
//  ToDoModel.swift
//  Note
//
//  Created by Youhan dou on 3/16/21.
//

import Foundation

struct ToDoEvent: Identifiable, Codable{
    var id: Int
    var text: String
    var date: Date = Date()
    var done: Bool = false
    init(id: Int, text: String) {
        self.text = text
        self.id = id
    }
}
