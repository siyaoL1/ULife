//
//  NoteNew.swift
//  Note
//
//  Created by Siyao Li on 3/19/21.
//

import SwiftUI


struct NoteDetail_2 : View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode

    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == modelData.currNote })!
    }

    var body: some View {
        let time = "\(modelData.notes[noteIndex].dateComponents.year!)/\(modelData.notes[noteIndex].dateComponents.month!)/\(modelData.notes[noteIndex].dateComponents.day!)"
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
//                            modelData.inNotes = false
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
//                            modelData.inNotes = false
                        }) {
                            Text("Save")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    HStack {
                        TextField("I feel like ...", text: $modelData.notes[noteIndex].title)
                            .font(.title)
                        Spacer()
                        FavoriteButton(isSet: $modelData.notes[noteIndex].isFavorite)
                    }
                    Text(time)
                        .font(.subheadline)
                    Divider()
                    
                    TextEditor(text: $modelData.notes[noteIndex].content)
                        .background(Color.clear)
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .frame(height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
//                MultilineTextView(text: $input)
            }
            .padding()
            .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
            .background(Color(red: 249/255, green: 247/255, blue: 236/255))
        }

    }
}


struct NoteDetail_2_Previews: PreviewProvider {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    static var modelData = ModelData()
    
    static var previews: some View {
        VStack {
            Button(action: {
                
            }) {
                Text("AddNote")
                    .foregroundColor(.yellow)
            }
//            NoteDetail_2(noteID: modelData.notes[0].id)
//                .environmentObject(modelData)
        }
        
    }
}
