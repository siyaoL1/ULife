//
//  SettingView.swift
//  Note
//
//  Created by Hongyang Lin on 4/1/21.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State var style = 0
    @State var expand = false
    @State var colors = [0: "Yellow", 1: "Purple"]
    
    var body: some View {
        GeometryReader { geo in
            HStack {
                Spacer().frame(width: 71)
                ZStack {
                    modelData.colorThemes[modelData.themeID]["Primary"]
                    VStack {
                        Button(action: {
                            withAnimation {
                                modelData.showSettingPanel = false
                            }
                        }) {
                            HStack {
                                Image(systemName: "chevron.up")
                            }
                        }
                        .padding(.top, 35)
                        .padding(.leading, 270)
                        .padding(.bottom, 20)
                            
                        Text("ULife").font(.title).fontWeight(.medium)
                            .frame(width: 180, height: 70)
                            .background(modelData.colorThemes[modelData.themeID]["Background"])
                            .cornerRadius(30)
                            .padding(.bottom, 30)
                        
                        HStack {
                            VStack(spacing: 30) {
                                HStack() {
                                    Text(colors[modelData.themeID]!)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                                        .resizable()
                                        .frame(width: 13, height: 6)
                                        .foregroundColor(.white)
                                }.onTapGesture {
                                    self.expand.toggle()
                                }
                                if expand {
                                    Button(action: {
                                        withAnimation {
                                            modelData.themeID = 0
                                        }
                                        self.expand.toggle()
                                    }) {
                                        Text(colors[0]!)
                                            .padding(10)
                                    }.foregroundColor(.white)
                                    Button(action: {
                                        withAnimation {
                                            modelData.themeID = 1
                                        }
                                        self.expand.toggle()
                                    }) {
                                        Text(colors[1]!)
                                            .padding(10)
                                    }.foregroundColor(.white)
                                }
                            }
                        }
                        .padding()
                        .background(modelData.colorThemes[modelData.themeID]["Secondary"])
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 5)
                        .animation(.spring())
                        
                        Spacer()
                            
                    }
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
//                    .padding(.top, 60)
                }
                .frame(width: geo.size.width - 70, height: 400, alignment: .topTrailing)
                .cornerRadius(40)
            }
        }
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(ModelData())
    }
}
