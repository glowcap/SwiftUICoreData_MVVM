//
//  PlayerCard.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/1/22.
//

import SwiftUI

struct PlayerCard: View {
  static let height: CGFloat = 200
  var player: Player
  
  var body: some View {
    VStack {
      VStack(spacing: 4) {
        Text("Player")
          .foregroundColor(.textSecondary)
          .font(.caption)
        Text(player.name)
          .bold()
          .foregroundColor(.textPrimary)
      }
      .padding(.vertical)
      VStack(spacing: 4) {
        Text("Games Played")
          .foregroundColor(.textSecondary)
          .font(.caption)
        Text("\(player.games?.count ?? 0)")
          .bold()
          .foregroundColor(.textPrimary)
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
        colors: [Color("PlayerGradientStart"), Color("PlayerGradientStop")],
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
