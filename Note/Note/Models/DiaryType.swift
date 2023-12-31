//
//  DiaryType.swift
//  Note
//
//  Created by Siyao Li on 4/16/21.
//

import Foundation

struct DiaryType: Hashable, Codable, Identifiable {
    var hasDeleted: Bool = false
    var id: UUID
    var title: String
    var content: String
    var emotion: String
    var date: String
    var rawDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM.d, yyyy"
        return formatter.date(from: date)!
    }
    var dateComponents: DateComponents {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM.d, yyyy"
        let dateFormated = formatter.date(from: date) ?? Date(timeIntervalSinceReferenceDate: 0) // default to 2001/12/31 19:00 if date entry does not exist.
        
        return Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateFormated)
    }
    
    
    init() {
        let dateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM.d, yyyy"
            return formatter
        }()
        
        self.id = UUID()
        self.title = ""
        self.content = ""
        self.date = dateFormat.string(from:Date())
        self.emotion = "Happy"
    }
}
