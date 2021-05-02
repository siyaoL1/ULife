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
        let currTime = Date()
        let date = DateFormatter.monthDayYearWithComma.string(from: currTime)
        let weekday = DateFormatter.weekday.string(from: currTime)
        let time = DateFormatter.time.string(from: currTime)
        
        ZStack {
            ScrollView {
                ZStack(alignment: .topTrailing) {
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
                        
                        VStack(alignment: .leading) {
                            Text(date)
                                .font(.system(size: 28, design: .rounded))
                                .padding(.bottom, 5)
                            Text(weekday)
                                .font(.system(size: 20, design: .rounded))
                            Text(time)
                                .font(.system(size: 20, design: .rounded))
                        }.padding(.top, 15)
                        .padding(.bottom, 30)

                        HStack {
                            TextField("I feel like ...", text: $diary.title)
                                .font(.title)
                            Spacer()
                        }

                        Divider()

                        TextEditor(text: $diary.content)
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .frame(height: 500, alignment: .center)
                    }.zIndex(0.0)
                    NewEmotion(emotion: $diary.emotion)
                        .offset(x: 9.0, y: 25.0)
                        .zIndex(1.0)
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
