//
//  ShadedPillButtonStyle.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/23/22.
//

import SwiftUI

struct ShadedPillStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 10)
      .background(
        LinearGradient(
          colors: [.seafoam, .bluesClues],
          startPoint: UnitPoint(x: 0.2, y: 0.2),
          endPoint: UnitPoint(x: 0.6, y: 1.8)
        )
      )
      .clipShape(Capsule())
      .shadow(color: .seafoam.opacity(0.4), radius: 4, x: 0, y: 0)
      .shadow(color: .bluesClues.opacity(0.4), radius: 4, x: 4, y: 4)
  }
  
}

/// allows for dot syntax button styling `.buttonStyle(.shadedPill)`
extension ButtonStyle where Self == ShadedPillStyle {
  static var shadedPill: Self { return .init() }
}

