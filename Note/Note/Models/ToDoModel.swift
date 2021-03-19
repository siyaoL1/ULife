//
//  ToDoModel.swift
//  Note
//
//  Created by Youhan dou on 3/16/21.
//

import Foundation

class ToDoList: ObservableObject {
    @Published var todolist = [Event]()
    
    init() {
        self.todolist.append(Event(id: Date(), name: "test1"))
        self.todolist.append(Event(id: Date(), name: "Finish Project"))
        self.todolist.append(Event(id: Date(), name: "Review class"))
    }
    
    func addEvent(id: Date, name: String) -> Void {
        self.todolist.append(Event(id: id, name: name))
    }
    
    
   
}
class Event: Identifiable{
    var id: Date
    var name: String
    var done: Bool = false
    init(id: Date, name: String) {
        self.name = name
        self.id = id
    }
}
