//
//  DiaryDetail.swift
//  Note
//
//  Created by Siyao Li on 4/16/21.
//

import SwiftUI

struct DiaryDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    
    var diaryIndex: Int {
        modelData.diaries.firstIndex(where: { $0.id == modelData.currDiary })!
    }
    
    var body: some View {
        let time = "\(modelData.diaries[diaryIndex].dateComponents.year!)/\(modelData.diaries[diaryIndex].dateComponents.month!)/\(modelData.diaries[diaryIndex].dateComponents.day!)"
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
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                        }
                    }

                    HStack {
                        TextField("I feel like ...", text: $modelData.diaries[diaryIndex].title)
                            .font(.title)
                        Spacer()
                    }
                    Text(time)
                        .font(.subheadline)
                    Divider()

                    TextEditor(text: $modelData.diaries[diaryIndex].content)
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
        
//        Button(action: {
//            let index = modelData.diaries.firstIndex(where: {$0.id == diary.id})
//            modelData.diaries[index!].hasDeleted.toggle()
//        }, label: {Text("D")})
}


struct DiaryDetail_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDetail()
    }
}
