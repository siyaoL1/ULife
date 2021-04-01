//
//  ContentView.swift
//  Note
//
//  Created on 3/15/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State var showList: Bool = false
    
    var body: some View {
        
        if !modelData.showCalendarPanel {
            ZStack(alignment: Alignment.top) {
                if modelData.showMainPanel {
                    VStack{
                        HStack(){
                            
                                Button(action: {modelData.showCalendarPanel = true}){
                                    Image(systemName: "calendar")
                                        .font(.system(size: 25.0))
                                }.padding()
                            
                            Spacer()
                            Button(action: {}){
                                Image(systemName: "gearshape")
                                    .font(.system(size: 25.0))
                            }.padding()
                        }
                    }
                }
                NotePanel()
            }
        } else {
            ToDoView()
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
