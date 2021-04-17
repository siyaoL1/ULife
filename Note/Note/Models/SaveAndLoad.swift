//
//  SaveLoadData.swift
//  Note
//
//  Created by yhd on 4/15/21.
//

import Foundation


class SaveLoadData {
    
    func saveToDoEventList(eventList: [ToDoEvent], forKey: String) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try?encoder.encode(eventList) {
            return saveData(data:data, forKey: forKey)
        }
        return false
    }
    
    func saveNoteList(noteList: [NoteType], forKey: String) -> Bool {
        let encoder = PropertyListEncoder()
        if let data = try?encoder.encode(noteList) {
            return saveData(data:data, forKey: forKey)
        }
        return false
    }
    
    func loadToDoEventList(forKey: String) -> [ToDoEvent]? {
        if let data = loadData(forKey: forKey) {
            let decoder = PropertyListDecoder()
            let eventList = try?decoder.decode([ToDoEvent].self, from: data)
            return eventList
        }
        return nil
    }
    
    func loadNoteList(forKey: String) -> [NoteType]? {
        if let data = loadData(forKey: forKey) {
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
