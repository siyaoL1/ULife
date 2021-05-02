//
//  NoteRow.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//

import SwiftUI

struct NoteRow: View {
    @EnvironmentObject var modelData: ModelData
    var note: NoteType
    
    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == note.id })!
    }
    
    var body: some View {
        let time = "\(note.dateComponents.year!)/\(note.dateComponents.month!)/\(note.dateComponents.day!)"
        
        HStack {
            Text(note.title)
                .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                .fontWeight(.light)
                .lineLimit(10)
            Spacer()
            
            Text(time).font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/).fontWeight(.light).foregroundColor(Color.gray).lineLimit(10)
//            Button(action: {
//                modelData.deleteNote(id: self.note.id)
//            }, label: {Text("d")})
            FavoriteButton(isSet: $modelData.notes[noteIndex].isFavorite)
        }
        .padding()
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        NoteRow(note: modelData.notes[1])
            .environmentObject(modelData)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
