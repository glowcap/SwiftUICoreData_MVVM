//
//  PlayerCard.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/1/22.
//

import SwiftUI

struct CardTitleModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .font(.caption)
      .foregroundColor(.textSecondary)
  }
  
}

struct CardMainTextModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(.textPrimary)
  }
}

extension View where Self == Text {

  func cardTitle() -> some View {
    modifier(CardTitleModifier())
  }
  
  func cardMainText() -> some View {
    self
      .bold() /// bold needs to be done here as it can't be inferred by ViewModifier
      .modifier(CardMainTextModifier())
  }
  
}

struct PlayerCard: View {
  static let height: CGFloat = 200
  var player: Player
  
  var body: some View {
    VStack {
      VStack(spacing: 4) {
        Text("Player")
          .cardTitle()
        Text(player.name)
          .cardMainText()
      }
      .padding(.vertical)
      VStack(spacing: 4) {
        Text("Games Played")
          .cardTitle()
        Text("\(player.games?.count ?? 0)")
          .cardMainText()
      }
      Spacer()
      HStack() {
        Spacer()
        Text("Agent: \(player.agent?.agentID ?? "")")
          .foregroundColor(.textSecondary)
          .font(.caption2)
      }
    }
    .padding()
    .frame(width: 240, height: PlayerCard.height)
    .background(
      LinearGradient(
        colors: [.seafoam, .bluesClues],
        startPoint: UnitPoint(x: 0.3, y: 0),
        endPoint: UnitPoint(x: 0.85, y: 1.0)
      )
    )
    .cornerRadius(24)
    .shadow(color: .seafoam.opacity(0.4), radius: 4, x: 0, y: 0)
    .shadow(color: .bluesClues.opacity(0.4), radius: 4, x: 4, y: 4)
  }
}

struct PlayerCard_Previews: PreviewProvider {
  static var previews: some View {
    PlayerCard(
      player: Player.example(context: CoreDataManager.empty.container.viewContext))
      .scaledToFit()
  }
}
