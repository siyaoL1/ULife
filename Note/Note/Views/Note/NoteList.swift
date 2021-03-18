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
    @State private var prompt: String = "Swipe up for notes"
    
    var filteredLandmarks: [NoteType] {
        modelData.notes.filter { note in
            (!showFavoritesOnly || note.isFavorite)
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 45)
                    .foregroundColor(.gray)
                    .frame(width: 60,height:10,alignment: .topLeading)
                    .padding(13)
                Text("").frame(height: 20)
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }.padding(20)

                ForEach(filteredLandmarks) { note in
                    NavigationLink(destination: NoteDetail(note: note)) {
                        NoteRow(note: note)
                    }
                }
                
            }
            .frame(height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(Color(red: 249/255, green: 247/255, blue: 236/255))
        }
//        .navigationBarHidden(true)
        .clipShape(RoundedRectangle(cornerRadius: 44))
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environmentObject(ModelData())
    }
}
