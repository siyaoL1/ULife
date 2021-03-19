//
//  NoteDetail.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//

import SwiftUI

struct NoteDetail: View {
    @EnvironmentObject var modelData: ModelData
    @State var input: String = "asdfasdfbas dfa fasdfa fadfasdfadsfa sdfa dfasdf asdfasdfas"
    @Environment(\.presentationMode) var presentationMode
    
    var note: NoteType
    
    var noteIndex: Int {
        modelData.notes.firstIndex(where: { $0.id == note.id })!
    }
        
    var body: some View {
        
        let time = "\(note.dateComponents.year!)/\(note.dateComponents.month!)/\(note.dateComponents.day!)"
        ZStack {

//            Color(red: 249/255, green: 247/255, blue: 236/255)
//                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(note.title)
                            .font(.title)
                        Spacer()
                        FavoriteButton(isSet: $modelData.notes[noteIndex].isFavorite)
                    }
                    Text(time)
                    Divider()
                    
//                    Text(note.content)
//                        .fixedSize(horizontal: false, vertical: true)
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
        //.navigationTitle(time)
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
