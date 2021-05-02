//
//  siyao_part.swift
//  Note
//
//  Created by Siyao Li on 3/15/21.
//

import SwiftUI

struct FloatingMenu: View {
    @EnvironmentObject var modelData: ModelData
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    @State var showMenuAction1 = false
    @State var showMenuAction2 = false
    
    var body: some View {
        VStack {
            Spacer()
//            if showMenuItem1 {
//                    Button(action: {
//                        self.showMenuAction1 = true
//                    }) {
//                        MenuItem(icon: "square.and.pencil").environmentObject(modelData)
//                    }.sheet(isPresented: $showMenuAction1, content: { NoteNew()})
//            }
//            if showMenuItem2 {
//                VStack{
//                    Button(action: {
//                        self.showMenuAction2 = true
//                    }) {
//                        MenuItem(icon: "checkmark.circle")
//                    }
//                }.sheet(isPresented: $showMenuAction2, content: { ToDoView()})
//            }
//            if showMenuItem3 {
//                VStack{
//                    MenuItem(icon: "camera.fill").environmentObject(modelData)
//                }
//            }
            Button(action: {
//                self.showMenu()
                self.showMenuAction1 = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }.sheet(isPresented: $showMenuAction1, content: { NoteNew().environmentObject(modelData)})
        }
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
}

struct FloatingMenu_Previews: PreviewProvider {
    static var modelData = ModelData()

    static var previews: some View {
        FloatingMenu()
            .environmentObject(modelData)
    }
}

struct MenuItem: View {
    @EnvironmentObject var modelData: ModelData
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                .frame(width: 55, height: 55)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}
