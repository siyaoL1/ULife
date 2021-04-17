//
//  NoteDetailInDropDown.swift
//  Note
//
//  Created by Hongyang Lin on 4/16/21.
//

import SwiftUI

struct NoteDetailInDropDown: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var note: NoteType
    
    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == note.id })!
    }
    
    func action(val: DragGesture.Value) {
        if detectDirection(value: val) == .left {
            self.presentationMode.wrappedValue.dismiss()

        }
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
                        .opacity(0.65)
                        .frame(height: UIScreen.main.bounds.height*0.5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
            .padding()
            .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
            .background(modelData.colorThemes[modelData.themeID]["Primary"])
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .gesture(DragGesture().onEnded(action))
    }
}

struct NoteDetailInDropDown_Previews: PreviewProvider {
    static var modelData = ModelData()
    static var previews: some View {
        NoteDetailInDropDown(note: modelData.notes[0]).environmentObject(ModelData())
    }
}
