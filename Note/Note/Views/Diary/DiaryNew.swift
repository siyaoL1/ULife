//
//  DiaryNew.swift
//  Note
//
//  Created by Siyao Li on 5/2/21.
//

import SwiftUI

struct DiaryNew: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State var diary: DiaryType = DiaryType()
    
    var body: some View {
        let time = "\(diary.dateComponents.year!)/\(diary.dateComponents.month!)/\(diary.dateComponents.day!)"
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
                            modelData.addDiary(diary: diary)
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                        }
                    }

                    HStack {
                        TextField("I feel like ...", text: $diary.title)
                            .font(.title)
                        Spacer()
                    }
                    Text(time)
                        .font(.subheadline)
                    Divider()

                    TextEditor(text: $diary.content)
                        .background(Color.clear)
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .frame(height: 400, alignment: .center)
                }
            }
            .padding()
            .foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
            .background(modelData.colorThemes[modelData.themeID]["Primary"])
            .ignoresSafeArea(edges: .bottom)

        }
    }
}

struct DiaryNew_Previews: PreviewProvider {
    static var previews: some View {
        DiaryNew()
    }
}
