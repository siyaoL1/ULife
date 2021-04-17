//
//  NoteNew.swift
//  Note
//
//  Created by Siyao Li on 3/19/21.
//

import SwiftUI


struct NoteNew : View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State var note: NoteType = NoteType(newId: -1)

    var body: some View {
        let time = "\(note.dateComponents.year!)/\(note.dateComponents.month!)/\(note.dateComponents.day!)"
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                Text("Back")
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            note.id = modelData.notes.count
                            modelData.addNote(note: note)
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    HStack {
                        TextField("I feel like ...", text: $note.title)
                            .font(.title)
                        Spacer()
                        FavoriteButton(isSet: $note.isFavorite)
                    }
                    Text(time)
                        .font(.subheadline)
                    Divider()
                    
                    TextEditor(text: $note.content)
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
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading:
//            Button(action: {
//                modelData.notes.append(note)
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                HStack {
//                    Image(systemName: "chevron.backward")
//                    Text("Save")
//                }
//            })
    }
}


struct NoteNew_Previews: PreviewProvider {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    static var modelData = ModelData()
    
    static var previews: some View {
        NoteNew()
            .environmentObject(modelData)
    }
}
