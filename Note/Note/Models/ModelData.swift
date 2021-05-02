/*
 Abstract:
 Storage for model data.
 */
import SwiftUI
import Foundation
import Combine

class ModelData: ObservableObject {
    @Published var notes: [NoteType] = []
//    @Published var diaries: [DiaryType] = load("diaryData.json")
    @Published var diaries: [DiaryType] = []
    @Published var todoList: [ToDoEvent] = []
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
    @Published var currNote: UUID = UUID()
    @Published var currDiary: UUID = UUID()
    @Published var lastDayOfDiary: String = "May.2, 2021"
    @Published var image: UIImage = UIImage()

    @Published var themeID: Int = 0
    let colorThemes: [[String:Color]] = [
        ["Primary": Color(red: 249/255, green: 247/255, blue: 236/255),
         "Secondary": Color.orange,
         "Text": Color(red: 105/255.0, green: 105/255.0, blue: 105/255.0),
         "Background": Color.secondary.opacity(0.2),
         "Addon": Color(red: 249/255, green: 240/255, blue: 220/255)
        ],
        ["Primary": Color(red: 238/255.0, green: 235/255.0, blue: 255/255.0),
//            "Primary": Color(red: 222/255.0, green: 245/255.0, blue: 255/255.0),
         "Secondary": Color(red: 177/255.0, green: 168/255.0, blue: 255/255.0),
         "Text": Color(red: 105/255.0, green: 105/255.0, blue: 105/255.0),
         "Background": Color.secondary.opacity(0.2),
         "Addon": Color(red: 245/255, green: 242/255, blue: 255/255)
        ]
    ]

    init() {
        var newNote = NoteType()
        newNote.title = "I'm a new note"
        newNote.content = "This is the content, asdfh jalsdfk lasdjflaksjdf klaj sdflk aj sdfla dsjdf."
        var testing = [NoteType]()
        testing.append(newNote)

        for note in self.saveAndLoad.loadNoteList() ?? testing {
            if !note.hasDeleted {
                self.notes.append(note)
            }
        }

        self.saveAndLoad.saveNoteList(noteList: self.notes)

        for e in self.saveAndLoad.loadToDoEventList() ?? [] {
            if !e.hasDeleted {
                self.todoList.append(e)
            }
        }
        self.saveAndLoad.saveToDoEventList(eventList: self.todoList)

        var newDiary = DiaryType()
        newDiary.title = "I'm a new diary"
        newDiary.content = "This is the content, asdfh jalsdfk lasdjflaksjdf klaj sdflk aj sdfla dsjdf."
        newDiary.date = "Apr.10, 2021"
        var newDiary2 = DiaryType()
        newDiary2.title = "I'm a new new diary"
        newDiary2.content = "This is the content, asdfh jalsdfk lasdjflaksjdf klaj sdflk aj sdfla dsjdf."
        newDiary2.date = "Apr.15, 2021"
        var newDiary3 = DiaryType()
        newDiary3.title = "I'm a newwww diary"
        newDiary3.content = "This is the content, asdfh jalsdfk lasdjflaksjdf klaj sdflk aj sdfla dsjdf."
        newDiary3.date = "Apr.29, 2021"
        var testing2 = [DiaryType]()
        testing2.insert(newDiary, at: 0)
        testing2.insert(newDiary2, at: 0)
        testing2.insert(newDiary3, at: 0)

        var latest: String = ""
        for diary in self.saveAndLoad.loadDiaryEventList() ?? testing2 {
            if !diary.hasDeleted {
                self.diaries.append(diary)
                latest = diary.date
            }
        }

        lastDayOfDiary = latest
        self.saveAndLoad.saveDiaryList(diaryList: self.diaries)
    }

    func addDiary(diary: DiaryType) -> Void {
        self.diaries.insert(diary, at: 0)
        self.lastDayOfDiary = diary.date
        self.saveAndLoad.saveDiaryList(diaryList: self.diaries)
    }

    func deleteDiary(id: UUID) -> Void {
        let index = diaries.firstIndex(where: {
            $0.id == id
        })
        self.diaries[index!].hasDeleted.toggle()
        self.saveAndLoad.saveDiaryList(diaryList: self.diaries)
    }

    func addEvent(text: String) -> Void {
        self.todoList.append(ToDoEvent(text: text))
        self.saveAndLoad.saveToDoEventList(eventList: self.todoList)
    }

    func deleteEvent(id: UUID) -> Void {
        let index = todoList.firstIndex(where: {
            $0.id == id
        })
        self.todoList[index!].hasDeleted.toggle()
        self.saveAndLoad.saveToDoEventList(eventList: self.todoList)
    }

    func addNote(note: NoteType) {
        self.notes.append(note)
        self.saveAndLoad.saveNoteList(noteList: self.notes)
    }

    func deleteNote(id: UUID) {
        let index = self.notes.firstIndex(where: {
            $0.id == id
        })
        self.notes[index!].hasDeleted.toggle()
        self.saveAndLoad.saveNoteList(noteList: self.notes)
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
