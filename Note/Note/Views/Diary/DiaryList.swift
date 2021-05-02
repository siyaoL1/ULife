//
//  DiraryList.swift
//  Note
//
//  Created by Siyao Li on 4/16/21.
//

import SwiftUI

struct DiaryList: View {
    @EnvironmentObject var modelData: ModelData
    @State var showDiaryDetail = false
    let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM.d, yyyy"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height:40)
            
            ScrollView(showsIndicators: false) {
                VStack{
                    if (modelData.lastDayOfDiary != dateFormat.string(from: Date())) {
                        Text("How's your day?")
                            .fontWeight(.bold)
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                        
                        NewButton()
                    } else {
                        Text("Welcome back! Anything new?")
                            .fontWeight(.bold)
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 200)
//                .background(Color.orange)
                
                ForEach(modelData.diaries) { diary in
                    HStack {
                        Spacer()
                        if !diary.hasDeleted {
                            DiaryRow(diary: diary)
                                .environmentObject(modelData)
                                .padding(.top, 5)
                                .padding(.bottom, 15)
                                .onTapGesture() {
                                    showDiaryDetail = true
                                    modelData.currDiary = diary.id
                                }
                                .sheet(isPresented: $showDiaryDetail, content: { DiaryDetail()})
                            Spacer()
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width)
                }
            }

        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: .top)
        .background(modelData.colorThemes[modelData.themeID]["Primary"])
    }
}

struct DiraryList_Previews: PreviewProvider {
    static var previews: some View {
        DiaryList()
            .environmentObject(ModelData())
    }
}
