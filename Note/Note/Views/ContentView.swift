//
//  ContentView.swift
//  Note
//
//  Created on 3/15/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var offset =
        CGSize(width: 0, height: UIScreen.main.bounds.height * 0.815)
    
    var body: some View {
        GeometryReader { geo in
            MainView()
                .offset(self.offset)
                .animation(.spring())
                .gesture(
                    DragGesture(minimumDistance: 100, coordinateSpace: .global)
                        .onChanged { g in
                            self.offset.height = g.translation.height
                        }
                        .onEnded {
                            if $0.translation.height < geo.size.height * 0.5 {
                                self.offset.height = geo.size.height * 0.07
                            } else {
                                self.offset.height = geo.size.height * 0.92
                            }
                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
