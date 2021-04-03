//
//  MainPanelBar.swift
//  Note
//
//  Created by Hongyang Lin on 4/1/21.
//

import SwiftUI

struct MainPanelBar: View {
    @EnvironmentObject var modelData: ModelData
    @Namespace var namespace
    
    var body: some View {
        HStack{
            Button(action: {
                withAnimation(.easeOut) {
                    modelData.showCalendarPanel = true
                }
            }){
                Image(systemName: "calendar")
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                    .font(.system(size: 25.0))
//                    .matchedGeometryEffect(id: "1", in: namespace, properties: .frame)
            }
            Spacer()
//            Spacer().frame(width: UIScreen.main.bounds.width*0.85)
            Button(action: {
                modelData.showSettingPanel = true
//                modelData.showNotesPanel = false
                //这行没有的也可以的
            }){
                Image(systemName: "list.dash")
                    .font(.system(size: 25.0))
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
            }
        }.padding()
    }
}

struct MainPanelBar_Previews: PreviewProvider {
    static var previews: some View {
        MainPanelBar().environmentObject(ModelData())
    }
}
