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
            Spacer().frame(height:95)
            VStack{
                Text("Hi there")
                Button(action: {
                    self.showDiaryDetail = true
                }) {
                    MenuItem(icon: "square.and.pencil").environmentObject(modelData)
                }.sheet(isPresented: $showDiaryDetail, content: { DiaryDetail()})
            }
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .background(Color.orange)
            
            ScrollView(showsIndicators: false) {
                ForEach(modelData.diaries) { diary in
                    HStack {
                        Spacer()
                        if !diary.hasDeleted {
                            DiaryRow(diary: diary)
                                .padding(.top, 5)
                                .padding(.bottom, 15)
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
