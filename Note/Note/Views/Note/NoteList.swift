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
            
            VStack(spacing: 0) {
                Spacer().frame(height:95)
                
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }.padding(20)

                ForEach(filteredLandmarks) { note in
                    NavigationLink(destination: NoteDetail(note: note).edgesIgnoringSafeArea(.bottom)) {
                        NoteRow(note: note)

                    }.simultaneousGesture(TapGesture().onEnded{
                        modelData.inNotes = true
                    })
                }

            }
            .frame(height: UIScreen.main.bounds.height*1.01, alignment: .topLeading)
            .background(modelData.colorThemes[modelData.themeID]["Primary"])
        }
        .clipShape(RoundedRectangle(cornerRadius: 44))
        
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environmentObject(ModelData())
    }
}
