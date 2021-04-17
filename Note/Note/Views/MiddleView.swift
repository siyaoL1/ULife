//
//  MiddleView.swift
//  Note
//
//  Created by Siyao Li on 4/1/21.
//

import SwiftUI

struct MiddleView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack(alignment: .top) {
            DiaryPanel()
                

            if modelData.showMainPanel {
                MainPanelBar(t:"")
                    .transition(.opacity)
            }
        }.background(Color.white)
    }
}

struct MiddleView_Previews: PreviewProvider {
    static var previews: some View {
        MiddleView()
            .environmentObject(ModelData())
    }
}
