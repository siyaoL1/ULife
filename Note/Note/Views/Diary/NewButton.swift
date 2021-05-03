//
//  NewButton.swift
//  Note
//
//  Created by Siyao Li on 5/2/21.
//

import SwiftUI

struct NewButton: View {
    @State var showNewDiary = false

    var body: some View {
        Button(action: {
            self.showNewDiary = true
        }) {
            MenuItem(icon: "square.and.pencil")
        }.sheet(isPresented: $showNewDiary, content: { DiaryNew()})
    }
}

struct NewButton_Previews: PreviewProvider {
    static var previews: some View {
        NewButton()
    }
}
