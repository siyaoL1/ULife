//
//  leftSwipeTest.swift
//  Note
//
//  Created by Siyao Li on 3/28/21.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        Color.red.ignoresSafeArea()
    }
}

struct SecondView: View {
    var body: some View {
        Color.blue.ignoresSafeArea()
    }
}

struct ThirdView: View {
    var body: some View {
        Color.yellow.ignoresSafeArea()
    }
}

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

struct LeftSwipeTest: View {
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
                FirstView()
                    .transition(.leftView)
                    .gesture(EdgeSwipe)
            } else if self.index == 1 {
                if prevIndex == 0 {
                    SecondView()
                        .transition(.rightView)
                        .gesture(EdgeSwipe)
                } else if prevIndex == 2 {
                    SecondView()
                        .transition(.leftView)
                        .gesture(EdgeSwipe)
                } else {
                    SecondView()
                        .transition(.leftView)
                        .gesture(EdgeSwipe)
                }

            } else {
                ThirdView()
                    .transition(.rightView)
                    .gesture(EdgeSwipe)
            }
                
            Button("Bla") {
                withAnimation {
                    self.index = index == 0 ? 1 : 0
                }
            }.foregroundColor(.white)
        }
        
        
    }
}

struct LeftSwipeTest_Previews: PreviewProvider {
    static var previews: some View {
        LeftSwipeTest()
    }
}
