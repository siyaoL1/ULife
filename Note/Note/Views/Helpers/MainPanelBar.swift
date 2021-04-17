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
    @State var t: String
    
    func action() {
        withAnimation(.easeInOut) {
            modelData.showCalendarDropDown = true
            modelData.showSearchBar = false
        }
    }
    
    var body: some View {
        HStack{
            Spacer()
            
            if modelData.showSearchBar {
                
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                            .onAppear {
                                modelData.showSearchBar = true
                            }
                            .animation(.easeInOut)
                        TextField("diary title", text: $t)
                            .frame(width:150)
                        
                    }
                    .padding()
                    .frame(height:30)
                    .overlay(RoundedRectangle(cornerRadius:20).stroke(modelData.colorThemes[modelData.themeID]["Secondary"]!))
                    .animation(.easeOut)
                    .transition(.scale)
                
                Button(action:{action()}) {
                    Image(systemName: "calendar")
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                        .font(.system(size: 25.0))
                        .animation(.easeInOut)
                }
            }

            Spacer()
            
            if !modelData.showSearchBar && !modelData.showCalendarDropDown {
                Button(action: {
                    modelData.showSettingPanel = true
                }){
                    Image(systemName: "list.dash")
                        .font(.system(size: 25.0))
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                }
            }
        }.padding()
    }
}

struct MainPanelBar_Previews: PreviewProvider {
    static var previews: some View {
        MainPanelBar(t: "").environmentObject(ModelData())
    }
}
