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
    @State var note: NoteType = NoteType()

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
                            modelData.addNote(note: note)
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
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
                        .frame(height: 400, alignment: .center)
                }
//                MultilineTextView(text: $input)
            }
            .padding()
            .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
            .background(modelData.colorThemes[modelData.themeID]["Primary"])
        }
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
