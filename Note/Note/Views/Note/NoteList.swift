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
    @State private var showNoteDetail = false

    var filteredLandmarks: [NoteType] {
        modelData.notes.filter { note in
            (!showFavoritesOnly || note.isFavorite)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }.padding(20)

            if (filteredLandmarks.count == 0) {
                Text("Nothing to see right now...")
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"]?.opacity(0.3))
            } else {
                ForEach(filteredLandmarks) { note in
                    if !note.hasDeleted {
                        Button(action: {
                            self.showNoteDetail = true
                            modelData.currNote = note.id
                        }) {
                            NoteRow(note: note)
                        }.sheet(isPresented: $showNoteDetail, content: { NoteDetail_2(noteID: note.id)})
                        .simultaneousGesture(TapGesture().onEnded{
                            modelData.inNotes = true
                        })
                    }
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .background(modelData.colorThemes[modelData.themeID]["Primary"])
        .background(NavigationConfigurator { nc in
            nc.navigationBar.barTintColor = UIColor(modelData.colorThemes[modelData.themeID]["Primary"]!);
            nc.navigationBar.titleTextAttributes = [.foregroundColor : modelData.colorThemes[modelData.themeID]["Primary"]!]
                    })
//        NavigationView {
//            VStack(spacing: 0) {
//                Toggle(isOn: $showFavoritesOnly) {
//                    Text("Favorites only")
//                }.padding(20)
//
//                if (filteredLandmarks.count == 0) {
//                    Text("Nothing to see right now...")
//                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"]?.opacity(0.3))
//                } else {
//                    ForEach(filteredLandmarks) { note in
//                        if !note.hasDeleted {
//                            NavigationLink(destination: NoteDetail_2(noteID: note.id).edgesIgnoringSafeArea(.bottom)) {
//                                NoteRow(note: note)
//
//                            }.simultaneousGesture(TapGesture().onEnded{
//                                modelData.inNotes = true
//                            })
//                        }
//                    }
//                }
//                Spacer()
//            }
//            .edgesIgnoringSafeArea(.bottom)
//            .navigationBarHidden(true)
//            .background(modelData.colorThemes[modelData.themeID]["Primary"])
//            .background(NavigationConfigurator { nc in
//                nc.navigationBar.barTintColor = UIColor(modelData.colorThemes[modelData.themeID]["Primary"]!);
//                nc.navigationBar.titleTextAttributes = [.foregroundColor : modelData.colorThemes[modelData.themeID]["Primary"]!]
//                        })
//        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environmentObject(ModelData())
    }
}
