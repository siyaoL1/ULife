//
//  EmotionPicker.swift
//  Note
//
//  Created by Siyao Li on 5/2/21.
//

import SwiftUI

struct EmotionPicker: View {
    @EnvironmentObject var modelData: ModelData
    @State var expand = false
    let emotionIcon = ["Sleepy": "zzz", "Fire":"flame", "Music":"music.note",
                       "Happy": "face.smiling", "Heart": "heart.fill", "Game": "gamecontroller",
                       "Sick": "cross.case"
    ]
    
    var diaryIndex: Int {
        modelData.diaries.firstIndex(where: { $0.id == modelData.currDiary })!
    }
    
    var body: some View {
        VStack{
            Image(systemName: emotionIcon[modelData.diaries[diaryIndex].emotion]!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                .cornerRadius(10)
                .padding(5)
            
            Image(systemName: expand ? "chevron.up" : "chevron.down")
                .resizable()
                .frame(width: 13, height: 8)
                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                .onTapGesture{
                    self.expand.toggle()
                }
            if expand {
                ScrollView(showsIndicators: false) {
                    ForEach(Array(emotionIcon.keys).sorted(), id: \.self) { key in
                        Button(
                            action: {
                                withAnimation {
                                    modelData.diaries[diaryIndex].emotion = key
                                }
                            }
                        ){
                            Image(systemName: emotionIcon[key]!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                                .cornerRadius(10)
                        }
                       
                    }
                }
                .frame(height: 300)
                .padding(5)
                .background(modelData.colorThemes[modelData.themeID]["Addon"])
//                .cornerRadius(10.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(modelData.colorThemes[modelData.themeID]["Background"]!, lineWidth: 2)
                )
            }
        }
        .padding(10)
//        .background(Color.green)
        .cornerRadius(10)
        .animation(.spring())
        .alignmentGuide(VerticalAlignment.center) { $0[.top] }
    }
}

struct EmotionPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmotionPicker()
            .environmentObject(ModelData())
    }
}
