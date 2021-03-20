//
//  NoteDetail.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//

import SwiftUI

struct NoteDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var note: NoteType
    
    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == note.id })!
    }
        
    var body: some View {
        // Retrive the time information from note data
        let time = "\(note.dateComponents.year!)/\(note.dateComponents.month!)/\(note.dateComponents.day!)"
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // Title field
                    HStack {
                        TextField("I feel like ...", text: $modelData.notes[noteIndex].title)
                            .font(.title)
                        Spacer()
                        FavoriteButton(isSet: $modelData.notes[noteIndex].isFavorite)
                    }
                    Text(time)
                        .font(.subheadline)
                    Divider()
                    
                    // Note field
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
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                HStack {
                    Image(systemName: "chevron.backward")
                    Text("")
                }
            }
        )
    }
    
}

struct NoteDetail_Previews: PreviewProvider {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    static var modelData = ModelData()
    
    static var previews: some View {
        NoteDetail(note: modelData.notes[0])
            .environmentObject(modelData)
    }

}
