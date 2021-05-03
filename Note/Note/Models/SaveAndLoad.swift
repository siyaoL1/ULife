//
//  SaveLoadData.swift
//  Note
//
//  Created by yhd on 4/15/21.
//

import Foundation


class SaveLoadData {
    
    func saveDiaryList(diaryList:[DiaryType]) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try?encoder.encode(diaryList) {
            return saveData(data:data, forKey: "diaryList")
        }
        return false
    }
    
    func saveToDoEventList(eventList: [ToDoEvent]) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try?encoder.encode(eventList) {
            return saveData(data:data, forKey: "eventList")
        }
        return false
    }
    
    func saveNoteList(noteList: [NoteType]) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try?encoder.encode(noteList) {
            return saveData(data:data, forKey: "noteList")
        }
        return false
    }
    
    func loadDiaryEventList() -> [DiaryType]? {
        if let data = loadData(forKey: "diaryList") {
            let decoder = PropertyListDecoder()
            let eventList = try?decoder.decode([DiaryType].self, from: data)
            return eventList
        }
        return nil
    }
    
    func loadToDoEventList() -> [ToDoEvent]? {
        if let data = loadData(forKey: "eventList") {
            let decoder = PropertyListDecoder()
            let eventList = try?decoder.decode([ToDoEvent].self, from: data)
            return eventList
        }
        return nil
    }
    
    func loadNoteList() -> [NoteType]? {
        if let data = loadData(forKey: "noteList") {
            let decoder = PropertyListDecoder()
            let noteList = try?decoder.decode([NoteType].self, from: data)
            return noteList
        }
        return nil
    }
    
    // forKey is full name
    func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        else {
            return nil
        }
        return documentURL.appendingPathComponent(key)
    }
    
    func saveData(data: Data, forKey: String) -> Bool {
        if let filePath = filePath(forKey: forKey) {
            let bool = FileManager.default.createFile(atPath: filePath.path, contents: data, attributes: nil)
            return bool
        }
        return false
    }
    
    func loadData(forKey: String) -> Data? {
        if let filePath = filePath(forKey: forKey) {
            let fileData = FileManager.default.contents(atPath: filePath.path)
            return fileData
        }
        return nil
    }
}
