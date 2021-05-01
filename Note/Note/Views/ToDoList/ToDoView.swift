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
    
//    HStack {
//        Text("New Event")
//                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
//        Spacer()
//    }
    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    Section(header: Text("New Event")
//                                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])) {
//                        HStack {
//                            TextField("To do ...", text: $text)
//
//                            Button(action: {
//                                if !text.isEmpty {
//                                    self.todolist.addEvent(id: Date(), name: self.text)
//                                }
//                                self.text = ""
//                            }, label: {
//                                Text("add")
//                            })
//                        }
//                    }
//                    Section {
//                        ForEach(self.todolist.todolist) {event in
//                            VStack(alignment: .leading) {
//                                CardView(event: event)
//                            }
//
//                        }.onDelete(perform: { indexSet in
//                            if let index = indexSet.first {
//                                let event = self.todolist.todolist[index]
//                                self.todolist.todolist.removeAll(where: {$0.id == event.id})
//                            } else {return}
//
//                        })
//
//                    }
//                }
//
//            }
//            //            .navigationBarTitle("To Do List", displayMode: .inline)
////            .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
//            .background(Color.white)
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(true)
//            .navigationBarHidden(true)
//        }
//        .edgesIgnoringSafeArea([.top])
        
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
            
            CustomizeList()
                .environmentObject(modelData)

            
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
