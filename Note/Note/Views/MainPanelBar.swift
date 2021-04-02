//
//  MainPanelBar.swift
//  Note
//
//  Created by Hongyang Lin on 4/1/21.
//

import SwiftUI

struct MainPanelBar: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        HStack{
//            Button(action: {}){
//                Image(systemName: "calendar")
//                    .font(.system(size: 25.0))
//            }
            Spacer().frame(width: UIScreen.main.bounds.width*0.85)
            Button(action: {
                modelData.showCalendarPanel = true
                modelData.showNotesPanel = false
            }){
                Image(systemName: "list.dash")
                    .font(.system(size: 25.0))
                    .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255))
            }
        }
    }
}

struct MainPanelBar_Previews: PreviewProvider {
    static var previews: some View {
        MainPanelBar().environmentObject(ModelData())
    }
}
