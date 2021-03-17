//
//  MainView.swift
//  Note
//
//  Created by Hongyang Lin on 3/16/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color(red: 0, green: 100, blue: 50)
            VStack {
                Text("Yo")
                Text("Welcome")
            }
        }.clipShape(RoundedRectangle(cornerRadius: 40))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
