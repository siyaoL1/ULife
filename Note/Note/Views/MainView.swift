//
//  MainView.swift
//  Note
//
//  Created by Hongyang Lin on 3/16/21.
//

import SwiftUI

struct MainView: View {
    
    
    var body: some View {
        ZStack (alignment: .top) {
            
            NoteList()
                .environmentObject(ModelData())
            
            // "+" button
            ZStack(alignment: .bottomTrailing) {
                HStack{
                    Spacer().frame(width: 240, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    FloatingMenu().padding(.bottom, 50)
                }
            }
            
        }.clipShape(RoundedRectangle(cornerRadius: 44))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
