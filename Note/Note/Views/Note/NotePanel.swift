//
//  NotePanel.swift
//  Note
//
//  Created by Hongyang Lin on 3/30/21.
//

import SwiftUI

enum PanelPosition: CGFloat {
    case top = 30
    case bottom = 700
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
            case .inactive:
                return false
            case .dragging:
                return true
        }
    }
}

struct NotePanel: View {
    @EnvironmentObject var modelData: ModelData
    @State var pos = PanelPosition.bottom
    @GestureState private var dragState = DragState.inactive
    
    var body: some View {
        
        ZStack (alignment: .top) {
            

            NoteList()
                .environmentObject(modelData)
            
            if !modelData.inNotes {
                VStack {
                    RoundedRectangle(cornerRadius: 45)
                        .foregroundColor(
                            Color(red: 211/255, green: 211/255, blue: 211/255))
                        .frame(width: 60, height:8)
                        .padding(.top, 10)
                    HStack{
                        Spacer().frame(width: 240, height: 100)
                        FloatingMenu()
                            .padding(.bottom, 30)
                            .environmentObject(modelData)
                    }
                }
            }
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 44))
        .offset(y: self.pos.rawValue + self.dragState.translation.height)
        .animation(.spring())
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
        .gesture(
            DragGesture()
                .updating($dragState) { drag, state, transaction in
                    state = .dragging(translation: drag.translation)
                }
                .onEnded(dragEnded)
        )
        .environmentObject(modelData)
    }
    
    private func dragEnded(drag: DragGesture.Value) {
        let positionTop: PanelPosition = .top
        let positionBelow: PanelPosition = .bottom
        let verticalMovement = drag.predictedEndLocation.y - drag.location.y
   
        if verticalMovement > 0 {
            self.pos = positionBelow
            modelData.showNotesPanel = false
            modelData.showMainPanel = true
            
        } else if verticalMovement < 0 {
            self.pos = positionTop
            modelData.showNotesPanel = true
            modelData.showMainPanel = false
            modelData.showSearchBar = false
            modelData.showSettingPanel = false
            modelData.showCalendarDropDown = false
        }
    }
}

struct NotePanel_Previews: PreviewProvider {
    static var previews: some View {
        NotePanel().environmentObject(ModelData())
    }
}
