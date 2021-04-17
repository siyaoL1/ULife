//
//  RightView.swift
//  Note
//
//  Created by Siyao Li on 4/1/21.
//

import SwiftUI

struct RightView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack {
            NoteList()
                .environmentObject(modelData)
            
            if !modelData.inNotes {
                HStack(){
                    Spacer()
                    FloatingMenu()
                        .padding(.bottom, 30)
                        .padding(.trailing, 30)
                        .environmentObject(modelData)
                }
            }
        }
        .padding(.top, 55)
        .background(modelData.colorThemes[modelData.themeID]["Primary"])
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct RightView_Previews: PreviewProvider {
    static var previews: some View {
        RightView()
            .environmentObject(ModelData())
    }
}
