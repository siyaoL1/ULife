//
//  ToDoView.swift
//  Note
//
//  Created by Youhan dou on 3/16/21.
//

import SwiftUI
let coloredNavAppearance = UINavigationBarAppearance()
let foreColor = Color(red: 77/255, green: 77/255, blue: 77/255)
//let backColor = Color(red: 249/255, green: 247/255, blue: 236/255)
let backColor = Color(red: 1, green: 1, blue: 1)

struct ToDoView: View {
    init() {
        //            coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(backColor)
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor(foreColor)]
        //            coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        //            UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
        //        UINavigationBar.appearance().backgroundColor = .blue
        UITableView.appearance().backgroundColor = UIColor(backColor)
        
    }
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var todolist = ToDoList()
    @State var newEvent: String = ""
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                        modelData.showCalendarPanel = false
                    }) {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }.padding()
                    Spacer()
                }
                
                
                List {
                    Section(header: Text("New Event")) {
                        HStack {
                            TextField("To do ...", text: $text)
                            
                            Button(action: {
                                if !text.isEmpty {
                                    self.todolist.addEvent(id: Date(), name: self.text)
                                }
                                self.text = ""
                            }, label: {
                                Text("add")
                            })
                        }
                    }
                    Section {
                        ForEach(self.todolist.todolist) {event in
                            VStack(alignment: .leading) {
                                CardView(event: event)
                            }
                            
                        }.onDelete(perform: { indexSet in
                            if let index = indexSet.first {
                                let event = self.todolist.todolist[index]
                                self.todolist.todolist.removeAll(where: {$0.id == event.id})
                            } else {return}
                            
                        })
                        
                    }
                }
                
            }
            //            .navigationBarTitle("To Do List", displayMode: .inline)
            .foregroundColor(foreColor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}
struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView().environmentObject(ModelData())
    }
}
