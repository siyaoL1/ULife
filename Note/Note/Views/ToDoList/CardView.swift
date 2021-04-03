//
//  CardView.swift
//  Note
//
//  Created by Youhan dou on 3/16/21.
//
import Foundation
import SwiftUI

extension DateFormatter {
    static var todoFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM dd, yyyy"
        return formatter
    }
}

struct CardView: View {
    @EnvironmentObject var modelData: ModelData
    var event: ToDoEvent
    let width : CGFloat = 60
    @Binding var indices : [Int]
    @State var offset = CGSize.zero
    @State var scale : CGFloat = 0.5
    @State var isChecked = false
    
    var body: some View {
        GeometryReader { geo in
            HStack (spacing : 0){
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(event.text).font(.headline)
//                        Text("\(event.date)")
                        Text(DateFormatter.todoFormatter.string(from: event.date))
                    }
                    .foregroundColor(modelData.colorThemes[modelData.themeID]["Text"])
                    .padding()
                    
                    Spacer()
                    
                    Image(systemName: self.isChecked ? "checkmark.square.fill" : "square")
                        .padding()
                        .onTapGesture {
                            self.isChecked.toggle()
                        }
                        .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                }
                .frame(width : geo.size.width, alignment: .leading)
                .cornerRadius(10)
                        
              ZStack {
                Image(systemName: "trash")
                  .font(.system(size: 20))
                  .scaleEffect(scale)
               }
                .frame(width: width, height: geo.size.height)
                .background(modelData.colorThemes[modelData.themeID]["Secondary"].opacity(0.15))
                .onTapGesture {
                    indices.append(event.id)
                 }
             }
//            .background(modelData.colorThemes[modelData.themeID]["Primary"]!.opacity(0.2))
//            .background(Color(red: 232/255, green: 232/255, blue: 232/255))
            .background(modelData.colorThemes[modelData.themeID]["Background"]!)
          }
            .offset(self.offset)
            .animation(.spring())
            .gesture(DragGesture()
                  .onChanged { gesture in
                               self.offset.width = gesture.translation.width
                              }
                  .onEnded { _ in
                             if self.offset.width < -50 {
                                    self.scale = 1
                                    self.offset.width = -60
                              } else {
                                    self.scale = 0.5
                                    self.offset = .zero
                             }
                           }
                    )
        
    }
}

struct CardView_Previews: PreviewProvider {
    @State static var indices: [Int] = [1]
    
    static var previews: some View {
        CardView(event: ToDoEvent(id: 0, text:"abc"), indices : $indices)
            .environmentObject(ModelData())
    }
}
