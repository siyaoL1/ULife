/*
Abstract:
A button that acts as a favorites indicator.
*/

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        Button(action: {
            isSet.toggle()
            modelData.inNotes = false
        }) {
            Image(systemName: isSet ? "star.fill" : "star")
                .foregroundColor(isSet ? Color.yellow : Color.gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true)).environmentObject(ModelData())
    }
}
