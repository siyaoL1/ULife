//
//  NoteViewInDropDown.swift
//  Note
//
//  Created by Hongyang Lin on 4/16/21.
//

import SwiftUI

struct NoteViewInDropDown: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode

    let date: Date
    var NotesOfTheDate: [NoteType] {
        modelData.notes.filter { note in
            (
                Calendar.current.dateComponents([.year,.month,.day], from: date)
                    == DateComponents(year: note.dateComponents.year,
                                      month: note.dateComponents.month,
                                      day: note.dateComponents.day)
            )
        }
    }
    
    func action(val: DragGesture.Value) {
        if detectDirection(value: val) == .left {
            self.presentationMode.wrappedValue.dismiss()

        }
    }
    
    var body: some View {
        VStack {
            
            ForEach(NotesOfTheDate) { note in
                NavigationLink(destination: NoteDetailInDropDown(note: note)) {
                    NoteRow(note: note).edgesIgnoringSafeArea(.bottom)
                }
                
            }
            modelData.colorThemes[modelData.themeID]["Primary"]
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .background(modelData.colorThemes[modelData.themeID]["Primary"])
        .gesture(DragGesture().onEnded(action))
    }
}

struct NoteViewInDropDown_Previews: PreviewProvider {
    static var previews: some View {
        NoteViewInDropDown(date:Date()).environmentObject(ModelData())
    }
}
