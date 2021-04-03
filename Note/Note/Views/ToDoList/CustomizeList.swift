//
//  CustomizeList.swift
//  Note
//
//  Created by Siyao Li on 4/2/21.
//

import SwiftUI

struct CustomizeList: View {
    @EnvironmentObject var modelData: ModelData
    @State var indices : [Int] = []
    
    var body: some View {
       GeometryReader { geo in
           ScrollView {
               LazyVStack(spacing: 5) {
//                ForEach (0..<modelData.todoList.todolist.count, id: \.self) { index in
//                       if !indices.contains(index) {
//                            CardView(index: index, event:, indices : $indices)
//                               .frame(height: 60)
//                       }
//                   }
//               }
                ForEach (modelData.todoList) { event in
                    if !indices.contains(event.id) {
                        CardView(event: event, indices : $indices)
                            .frame(width: UIScreen.main.bounds.size.width - 40, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//                            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1.0)), radius: 10, x: 10, y: 10)

                    }
                }
               }
           }
       }
    }
}

//List {
//    ForEach(self.todolist.todolist) {event in
//        VStack(alignment: .leading) {
//            CardView(event: event, index: 0, indices : $indices)
//                .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
//                .environmentObject(modelData)
//        }
//
//    }.onDelete(perform: { indexSet in
//        if let index = indexSet.first {
//            let event = self.todolist.todolist[index]
//            self.todolist.todolist.removeAll(where: {$0.id == event.id})
//        } else {return}
//
//    })
//}.onAppear {
//    UITableView.appearance().separatorStyle = .none
//}
//.background(Color(red: 249/255, green: 248/255, blue: 250/255))

struct CustomizeList_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeList()
            .environmentObject(ModelData())
    }
}
