//
//  NoteRow.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//

import SwiftUI

struct NoteRow: View {
    var note: NoteType
    
    
    var body: some View {
        let time = "\(note.dateComponents.year!)/\(note.dateComponents.month!)/\(note.dateComponents.day!)"
        
        HStack {
            Text(note.title)
                .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                .fontWeight(.light)
                .lineLimit(10)
            Spacer()
            
            Text(time).font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/).fontWeight(.light).foregroundColor(Color.gray).lineLimit(10)
            if note.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            } else {
                Image(systemName: "star.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

struct NoteRow_Previews: PreviewProvider {
    static var notes = ModelData().notes
    
    static var previews: some View {
        NoteRow(note: notes[1])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
