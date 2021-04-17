/*
 Abstract:
 Storage for model data.
 */
import SwiftUI
import Foundation
import Combine

class ModelData: ObservableObject {
    @Published var notes: [NoteType] = load("noteData.json")
//    @Published var todoList: [ToDoEvent] = [ToDoEvent]()
//    @Published var notes: [NoteType]
    @Published var todoList: [ToDoEvent]
    var saveAndLoad: SaveLoadData = SaveLoadData()
    @Published var inNotes: Bool = false
    @Published var showNotesPanel: Bool = true
    @Published var showMainPanel: Bool = true
    @Published var showCalendarPanel: Bool = false
    @Published var showCalendarDropDown: Bool = false
    @Published var showSettingPanel: Bool = false
    @Published var alwaysFalse: Bool = false
    @Published var showSearchBar: Bool = false
    @Published var showCollapseBack: Bool = true
    
    @Published var themeID: Int = 0
    let colorThemes: [[String:Color]] = [
        ["Primary": Color(red: 249/255, green: 247/255, blue: 236/255),
         "Secondary": Color.orange,
         "Text": Color(red: 105/255.0, green: 105/255.0, blue: 105/255.0),
         "Background": Color.secondary.opacity(0.2)
        ],
        ["Primary": Color(red: 238/255.0, green: 235/255.0, blue: 255/255.0),
//            "Primary": Color(red: 222/255.0, green: 245/255.0, blue: 255/255.0),
         "Secondary": Color(red: 177/255.0, green: 168/255.0, blue: 255/255.0),
         "Text": Color(red: 105/255.0, green: 105/255.0, blue: 105/255.0),
         "Background": Color.secondary.opacity(0.2)
        ]
    ]
    
    init() {
        self.notes = self.saveAndLoad.loadNoteList(forKey: "noteList") ?? []
        self.todoList = self.saveAndLoad.loadToDoEventList(forKey: "eventList") ?? []
//        self.todoList.append(ToDoEvent(id: 0, text: "test1"))
//        self.todoList.append(ToDoEvent(id: 1, text: "Finish Project"))
//        self.todoList.append(ToDoEvent(id: 2, text: "Review class"))
    }
    
    func addEvent(id: Int, text: String) -> Void {
        self.todoList.append(ToDoEvent(id: id, text: text))
        self.saveAndLoad.saveToDoEventList(eventList: self.todoList, forKey: "eventList")
    }
    
    func addNote(note: NoteType) {
        self.notes.append(note)
        self.saveAndLoad.saveNoteList(noteList: self.notes, forKey: "noteList")
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
