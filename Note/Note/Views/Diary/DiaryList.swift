//
//  DiraryList.swift
//  Note
//
//  Created by Siyao Li on 4/16/21.
//

import SwiftUI

struct DiaryList: View {
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height:95)
            ScrollView(showsIndicators: false) {
                ForEach(modelData.diaries) { diary in
                    HStack {
                        Spacer()
                        DiaryRow(diary: diary)
                        Spacer()
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
