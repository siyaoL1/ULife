//
//  ToDoView.swift
//  Note
//
//  Created by Youhan dou on 3/16/21.
//

import SwiftUI


struct ToDoView: View {
    @EnvironmentObject var modelData: ModelData
    @State var newEvent: String = ""
    @State var text: String = ""
    @State var indices: [Int] = [1]
    
    var filteredToDos: [ToDoEvent] {
        modelData.todoList.filter { todo in
            !todo.hasDeleted
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("NEW EVENT")
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                    .font(.system(size: 15.0))
                Spacer()
            }
            
            HStack {
                TextField("To do ...", text: $text)
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                
                Button(action: {
                    if !text.isEmpty {
                        modelData.addEvent(text: self.text)
                    }
                    self.text = ""
                }, label: {
                    Text("add")
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                })
            }.padding()
            .background(Color.white)
            .padding(.bottom, 20)
            
            if (filteredToDos.count == 0) {
                Text("You don't have any to-do right now...")
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"]?.opacity(0.3))
            } else {
                CustomizeList()
                    .environmentObject(modelData)
            }
            

            
            Spacer()
        }
        .padding(.top, 45)
        .padding(20)
        .background(modelData.colorThemes[modelData.themeID]["Primary"])
        .edgesIgnoringSafeArea(.all)
        
    }
}
struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView().environmentObject(ModelData())
    }
}
