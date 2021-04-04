//
//  ContentView.swift
//  Note
//
//  Created on 3/15/21.
//

import SwiftUI
import CoreData

extension AnyTransition {
    static var leftView: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    static var rightView: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .leading)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var index: Int = 1
    @State private var prevIndex: Int = 1
    
    var EdgeSwipe: some Gesture {
        DragGesture()
            .onEnded({gesture in
                withAnimation {
                    let direction = detectDirection(value: gesture)
                    if gesture.startLocation.x < CGFloat(10.0) && direction == .left {
                        print("left edge swipe")
                        if self.index > 0 {
                            self.prevIndex = index
                            self.index -= 1
                        }
                    } else if gesture.startLocation.x > CGFloat(UIScreen.main.bounds.size.width - 10.0) && direction == .right {
                        print("rigth edge swipe")
                        if self.index < 2 {
                            self.prevIndex = index
                            self.index += 1
                        }
                    }
                 }
            })
    }
    
    var body: some View {
        ZStack {
            if self.index == 0 {
                LeftView()
                    .transition(.leftView)
                    .gesture(EdgeSwipe)
                    .zIndex(0)
            } else if self.index == 1 {
                if prevIndex == 0 {
                    MiddleView()
                        .environmentObject(modelData)
                        .transition(.rightView)
                        .gesture(EdgeSwipe)
                        .zIndex(0)
                } else if prevIndex == 2 {
                    MiddleView()
                        .environmentObject(modelData)
                        .transition(.leftView)
                        .gesture(EdgeSwipe)
                        .zIndex(0)
                } else {
                    MiddleView()
                        .environmentObject(modelData)
                        .transition(.leftView)
                        .gesture(EdgeSwipe)
                        .zIndex(0)
                }

            } else {
                RightView()
                    .transition(.rightView)
                    .gesture(EdgeSwipe)
                    .zIndex(0)
            }
            
            if modelData.showCalendarPanel {
                // Need to use asymmetric transition due to the ZStack disappearing sequence.
                CalendarView().zIndex(1)
                    .transition(.asymmetric(
                                    insertion: AnyTransition.opacity.animation(.easeInOut(duration: 0.6)),
                                    removal: AnyTransition.opacity))
                    
            }
            
            if modelData.showSettingPanel {
                SettingView().zIndex(1)
                    .transition(.asymmetric(
                                    insertion: AnyTransition.opacity.animation(.easeInOut(duration: 0.6)),
                                    removal: AnyTransition.opacity))
            }
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ModelData())
    }
}
