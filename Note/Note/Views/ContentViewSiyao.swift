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
            .padding(.top, -20)
    }
}

struct ContentViewSiyao_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentViewSiyao()
                .environmentObject(ModelData())

            ZStack(alignment: .bottomTrailing) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                FloatingMenu()
                    .padding()
            }
        }
    }
}
