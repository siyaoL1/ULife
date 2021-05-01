//
//  ToDoModel.swift
//  Note
//
//  Created by Youhan dou on 3/16/21.
//

import Foundation

struct ToDoEvent: Identifiable, Codable{
    var hasDeleted: Bool = false
    var id: UUID
    var text: String
    var date: Date = Date()
    var done: Bool = false
    init(text: String) {
        self.text = text
        self.id = UUID()
    }
}
