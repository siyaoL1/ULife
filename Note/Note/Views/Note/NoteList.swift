//
//  NoteList.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//

import SwiftUI

struct NoteList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false

    var filteredLandmarks: [NoteType] {
        modelData.notes.filter { note in
            (!showFavoritesOnly || note.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 0) {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }.padding()

                ForEach(filteredLandmarks) { note in
                    NavigationLink(destination: NoteDetail(note: note)) {
                        NoteRow(note: note)
                    }
                }
                Spacer()
            }.frame(width: 350)
//            .navigationTitle("Notes")
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environmentObject(ModelData())
    }
}
