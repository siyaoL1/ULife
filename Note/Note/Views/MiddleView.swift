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
                MainPanelBar()
                    .transition(.opacity)
            }
        }.background(Color.white)
    }
}

//extension View {
//    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
//        NavigationView {
//            ZStack {
//                self
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//                NavigationLink(
//                    destination: view
//                        .navigationBarTitle("")
//                        .navigationBarHidden(true),
//                    isActive: binding
//                ) {
//                    EmptyView()
//                }
//            }
//        }
//    }
//}

struct MiddleView_Previews: PreviewProvider {
    static var previews: some View {
        MiddleView()
            .environmentObject(ModelData())
    }
}
