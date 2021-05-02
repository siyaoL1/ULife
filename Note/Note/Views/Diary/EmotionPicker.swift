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
    
    var body: some View {
        VStack{
            Text("Dropdown").onTapGesture{
                self.expand.toggle()
            }
            if expand {
                ScrollView {
                    ForEach(Array(emotionIcon.keys), id: \.self) { key in
                        Image(systemName: emotionIcon[key]!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                            .cornerRadius(10)
                            .padding(10)
                    }
                    
                    Button(action: {}) {
                        Text("Dropdown")
                    }
                    Button(action: {}) {
                        Text("Dropdown")
                    }
                    Button(action: {}) {
                        Text("Dropdown")
                    }
                }
                .frame(height: 100)
                .background(Color.green)
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
