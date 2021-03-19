//
//  SwipeDirection.swift
//  Note
//
//  Created by Siyao Li on 3/19/21.
//
import SwiftUI
import Foundation

enum SwipeHVDirection: String {
    case left, right, up, down, none
}

func detectDirection(value: DragGesture.Value) -> SwipeHVDirection {
if value.startLocation.x < value.location.x - 24 {
        return .left
      }
      if value.startLocation.x > value.location.x + 24 {
        return .right
      }
      if value.startLocation.y < value.location.y - 24 {
        return .down
      }
      if value.startLocation.y > value.location.y + 24 {
        return .up
      }
  return .none
  }
