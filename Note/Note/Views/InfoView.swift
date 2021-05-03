//
//  InfoView.swift
//  Note
//
//  Created by Hongyang Lin on 5/2/21.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var modelData: ModelData
    func dateToString(_ d:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        
        return formatter.string(from: d)
    }
    var body: some View {
        VStack(spacing:20){
            
            Spacer().frame(height: UIScreen.main.bounds.height*0.25)
            
            Image("logo")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
            
            Text("\(dateToString(Date()))")
                //.frame(width:150, height: 50)
                .padding()
                .font(.system(size: 25.0))
                .foregroundColor(modelData.colorThemes[modelData.themeID]["Secondary"])
                .background(modelData.colorThemes[modelData.themeID]["Primary"])
                .cornerRadius(25)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        }.transition(.asymmetric(
                        insertion: AnyTransition.opacity.animation(.easeInOut(duration: 0.6)),
                        removal: AnyTransition.opacity))
        MainPanelBar(t:"")
            .transition(.asymmetric(
                            insertion: AnyTransition.opacity.animation(.easeInOut(duration: 0.6)),
                            removal: AnyTransition.opacity))
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().environmentObject(ModelData())
    }
}
