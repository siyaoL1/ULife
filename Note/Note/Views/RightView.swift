//
//  RightView.swift
//  Note
//
//  Created by Siyao Li on 4/1/21.
//

import SwiftUI

struct RightView: View {
    @EnvironmentObject var modelData: ModelData

    
    var body: some View {
        ZStack {
            modelData.colorThemes[modelData.themeID]["Primary"]
            
            Button("More to come...") {
//                withAnimation {
//                    self.index = index == 0 ? 1 : 0
//                }
            }
        }.foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct RightView_Previews: PreviewProvider {
    static var previews: some View {
        RightView()
            .environmentObject(ModelData())
    }
}
