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
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height:40)
            
            ScrollView(showsIndicators: false) {
                VStack{
//                    根据今天有没有记日记变显示的东西， Welcome Back, anything new?
                    Text("How's your day?")
                        .fontWeight(.bold)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                    Button(action: {
                        self.showDiaryDetail = true
                    }) {
                        MenuItem(icon: "square.and.pencil").environmentObject(modelData)
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: 200)
//                .background(Color.orange)
                
                ForEach(modelData.diaries) { diary in
                    HStack {
                        Spacer()
                        if !diary.hasDeleted {
                            DiaryRow(diary: diary)
                                .padding(.top, 5)
                                .padding(.bottom, 15)
                                .onTapGesture {
                                    showDiaryDetail = true
                                }
                            Spacer()
                        }
                        
                    }.frame(width: UIScreen.main.bounds.width)
                }
            }

        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, alignment: .top)
        .background(modelData.colorThemes[modelData.themeID]["Primary"])
        .sheet(isPresented: $showDiaryDetail, content: { DiaryDetail()})
    }
}

struct DiraryList_Previews: PreviewProvider {
    static var previews: some View {
        DiaryList()
            .environmentObject(ModelData())
    }
}
