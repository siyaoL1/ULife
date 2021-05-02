//
//  DropMenu.swift
//  Note
//
//  Created by Hongyang Lin on 4/16/21.
//

import SwiftUI

struct DropMenu: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State var style = 0
    @State var expand = false
    @State var colors = [0: "Yellow", 1: "Purple"]
    
    func action() {
        
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack{
            HStack {
                Spacer()
                ZStack {
                    modelData.colorThemes[modelData.themeID]["Primary"]

                    VStack(spacing:3) {
                        
//                            Button(action: {
//                                withAnimation {
//                                    modelData.showCalendarDropDown = false
//                                    modelData.showSearchBar = true
//                                }
//                            }) {
//                                HStack {
//                                    Image(systemName: "chevron.up")
//                                }
//                            }
//                            .padding(.top, 5)
                        
                        CalendarDropDown()
                        
                    }
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                    Spacer()
                    
                }
                .frame(width: geo.size.width - 50, height: geo.size.height*0.6, alignment: .topTrailing)
                .cornerRadius(40)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
                Spacer()
            }
                Text("Search Notes")
                    .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(modelData.colorThemes[modelData.themeID]["Primary"])
                    .cornerRadius(40)
                    .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            }
        }
        
    }
}

struct DropMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropMenu().environmentObject(ModelData())
    }
}
