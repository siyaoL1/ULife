//
//  CustomizeList.swift
//  Note
//
//  Created by Siyao Li on 4/2/21.
//

import SwiftUI

struct CustomizeList: View {
    @EnvironmentObject var modelData: ModelData
    @State var indices : [UUID] = []
    
    var body: some View {
       GeometryReader { geo in
        ScrollView {
            LazyVStack(spacing: 5) {
                 ForEach (modelData.todoList) { event in
                     if !event.hasDeleted {
                         CardView(event: event, indices : $indices, isChecked: $modelData.todoList[modelData.todoList.firstIndex(where: {$0.id == event.id})!].done)
                             .frame(width: UIScreen.main.bounds.size.width - 40, height: 80)
                             .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                     }
                 }
            }
        }
       }
    }
}

struct CustomizeList_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeList()
            .environmentObject(ModelData())
    }
}
