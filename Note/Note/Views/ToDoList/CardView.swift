//
//  CardView.swift
//  Note
//
//  Created by Youhan dou on 3/16/21.
//

import SwiftUI

struct CardView: View {
    var event: Event
    @State var isChecked = false
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(event.name).font(.headline)
                Text("\(event.id)")
                
            }
            .padding()
            
            
            Spacer()
            
            
            Image(systemName: self.isChecked ? "checkmark.square.fill" : "square")
                .padding()
                .onTapGesture {
                    self.isChecked.toggle()
                }
            
            
        }
        .frame(height: 75)
//        .background(Color.white)
        .cornerRadius(10)
//        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x:0, y:10)
        .background(Color(red: 249/255, green: 247/255, blue: 236/255))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(event: Event(id:Date(), name:"abc"))
    }
}
