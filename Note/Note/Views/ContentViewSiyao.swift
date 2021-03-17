//
//  ContentViewSiyao.swift
//  Note
//
//  Created by Siyao Li on 3/17/21.
//
import SwiftUI

struct ContentViewSiyao: View {
    var body: some View {
        NoteList()
    }
}

struct ContentViewSiyao_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentViewSiyao()
                .environmentObject(ModelData())
            FloatingMenu()
        }
    }
}
