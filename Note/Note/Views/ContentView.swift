//
//  ContentView.swift
//  Note
//
//  Created on 3/15/21.
//

import SwiftUI
import CoreData

extension View {
    // Navigate to a new view.
    // - Parameters:
    // - view: View to navigate to.
    // - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var showList: Bool = false
    
    var body: some View {
        ZStack(alignment: Alignment.top) {
            if modelData.showMainPanel {
                HStack{
                    MainPanelBar().padding(.top, -UIScreen.main.bounds.width*0.95).navigate(to: ToDoView(), when: $modelData.showCalendarPanel)
                }
            }
            if modelData.showNotesPanel {
                NotePanel()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
