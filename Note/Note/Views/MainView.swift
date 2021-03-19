//
//  MainView.swift
//  Note
//
//  Created by Hongyang Lin on 3/16/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack (alignment: .top) {
            
            NoteList()
                .environmentObject(modelData)
        
            VStack {
                    RoundedRectangle(cornerRadius: 45)
                        .foregroundColor(Color(red: 211/255, green: 211/255, blue: 211/255))
                        .frame(width: 60, height:8)
                        .padding(.top, 10)
                HStack{
                    Spacer().frame(width: 240, height: 100)
                    FloatingMenu().padding(.bottom, 50)
                        .environmentObject(modelData)
                }
            }
            
        }.clipShape(RoundedRectangle(cornerRadius: 44))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ModelData())
    }
}
