/*
 
 Abstract:
 A representation of a single note.
 */

import Foundation

struct NoteType: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var content: String
    var isFavorite: Bool
    
    private var date: String
    var dateComponents: DateComponents {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let dateFormated = formatter.date(from: date) ?? Date(timeIntervalSinceReferenceDate: 0) // default to 2001/12/31 19:00 if date entry does not exist.
        
        return Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: dateFormated)
    }
}

