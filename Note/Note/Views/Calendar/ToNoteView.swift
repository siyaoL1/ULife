//
//  ToNoteView.swift
//  Note
//
//  Created by Siyao Li on 4/1/21.
//

import SwiftUI

struct ToNoteView : View {
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
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation() {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                    .foregroundColor(.orange)
                }.padding()
                Spacer()
            }
            .background(Color.white)
            
            ForEach(NotesOfTheDate) { note in
                NavigationLink(destination: NoteDetail(note: note)) {
                    NoteRow(note: note)
                }
                
            }
            Spacer()
        }
        .navigationBarHidden(true)
        .background(Color(red: 249/255, green: 247/255, blue: 236/255))


//        .navigationBarTitle("Notes", displayMode: .inline)

//        .frame(height: UIScreen.main.bounds.height*0.89)
//        .clipShape(RoundedRectangle(cornerRadius: 44))
    }
}
