//
//  MainView.swift
//  Note
//
//  Created by Hongyang Lin on 3/16/21.
//

import SwiftUI

struct MainView: View {
    @State private var prompt: String = "Swipe up for notes"
    
    var body: some View {
        ZStack (alignment: .top) {
            Color(red: 249/255, green: 247/255, blue: 236/255)
            VStack(spacing: -5) {
                RoundedRectangle(cornerRadius: 45)
                    .foregroundColor(.gray)
                    .frame(width: 60,height:10,alignment: .topLeading)
                    .padding(7)
                Text(prompt).foregroundColor(Color(red: 77/255, green: 77/255, blue: 77/255))
            }
        }.clipShape(RoundedRectangle(cornerRadius: 44))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
