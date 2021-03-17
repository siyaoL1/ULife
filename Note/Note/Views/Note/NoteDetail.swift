//
//  NoteDetail.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//

import SwiftUI

struct NoteDetail: View {
    var note: NoteType
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NoteDetail_Previews: PreviewProvider {
    static var notes = ModelData().notes
    
    static var previews: some View {
        NoteDetail(note: notes[0])
    }
}
