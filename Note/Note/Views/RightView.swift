//
//  RightView.swift
//  Note
//
//  Created by Siyao Li on 4/1/21.
//

import SwiftUI

struct RightView: View {
    @EnvironmentObject var modelData: ModelData
    
    func action() {
        withAnimation(.easeInOut) {
            modelData.showCalendarDropDown = true
            modelData.showSearchBar = false
        }
    }
    
    var body: some View {
        ZStack {
            modelData.colorThemes[modelData.themeID]["Primary"]
            
            if modelData.showCalendarPanel {
                // Need to use asymmetric transition due to the ZStack disappearing sequence.
                DropMenu()
                    .zIndex(1)
                    .transition(.asymmetric(
                                    insertion: AnyTransition.opacity.animation(.easeInOut(duration: 0.6)),
                                    removal: AnyTransition.opacity))
            } else {
                NoteList()
                    .background(modelData.colorThemes[modelData.themeID]["Primary"])
                    .ignoresSafeArea()
                    .background(modelData.colorThemes[modelData.themeID]["Primary"])
                    .environmentObject(modelData)
                
                HStack(){
                    Spacer()
                    FloatingMenu()
                        .padding(.bottom, 30)
                        .padding(.trailing, 30)
                        .environmentObject(modelData)
                }
            }
        }
        .padding(.top, 55)
        .background(modelData.colorThemes[modelData.themeID]["Primary"])
        .edgesIgnoringSafeArea(.all)
    }
}

struct RightView_Previews: PreviewProvider {
    static var previews: some View {
        RightView()
            .environmentObject(ModelData())
    }
}
