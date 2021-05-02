//
//  DiaryRow.swift
//  Note
//
//  Created by Siyao Li on 4/16/21.
//

import SwiftUI

struct DiaryRow: View {
    @EnvironmentObject var modelData: ModelData
    var diary: DiaryType
    let weatherIcon = ["Sunny": "sun.max", "Sleepy": "zzz"]
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack {
                    Image(systemName: weatherIcon[diary.weather] ?? "zzz")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                        .cornerRadius(10)
                        .padding(10)
                    Spacer()
                    Button(action: {
                        let index = modelData.diaries.firstIndex(where: {$0.id == diary.id})
                        modelData.diaries[index!].hasDeleted.toggle()
                    }, label: {Text("D")})
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(diary.date)
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                        .padding(.top, 5)
                        .padding(.leading, 5)
                    Text(diary.title)
                        .frame(width: 170, alignment: .topLeading)
                        .font(.system(size: 18, weight: .medium, design: .default))
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                        .padding(.leading, 5)
                    Text(diary.content)
                        .padding(.top, 5)
                        .padding(.leading, 5)
                        .padding(.trailing, 5)
                        .frame(width: 170, height: 100, alignment: .topLeading)
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                        .background(modelData.colorThemes[modelData.themeID]["Background"])
                        .cornerRadius(5)
                        .padding(.bottom, 5)
                    Spacer()

                }
                
                .frame(width: 190, alignment:.topLeading)
//                    .background(Color.white)

            }
        }
        .frame(width: 330, height: 170, alignment: .topLeading)
        .padding(10)
        .background(modelData.colorThemes[modelData.themeID]["Addon"])
        .cornerRadius(10)
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 174/255, green: 174/255, blue: 192/255), lineWidth: 2)
        )
        .shadow(color: Color(red: 174/255, green: 174/255, blue: 192/255).opacity(0.4), radius: 15, x: 10, y: 10)
//        .shadow(color: Color(red: 255/255, green: 255/255, blue: 255/255), radius: 15, x: -10, y: -10)
    }
}

struct DiaryRow_Previews: PreviewProvider {
    static var modelData = ModelData()
    
    static var previews: some View {
        ZStack {
            Color(red: 249/255, green: 247/255, blue: 236/255)
            DiaryRow(diary: modelData.diaries[0])
                .environmentObject(modelData)
        }
        
    }
}
