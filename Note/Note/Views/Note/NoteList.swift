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
        ZStack {
            VStack(spacing: 0) {
//                if modelData.showMainPanel {
//                    CalendarView()
//                        .transition(.opacity)
//                }
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }.padding(20)

                if (filteredLandmarks.count == 0) {
                    Text("Nothing to see right now...")
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"]?.opacity(0.3))
                } else {
                    ForEach(filteredLandmarks) { note in
                        if !note.hasDeleted {
                            NoteRow(note: note)
                        }
                    }
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(modelData.colorThemes[modelData.themeID]["Primary"])
        }
    }
}

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environmentObject(ModelData())
    }
}
