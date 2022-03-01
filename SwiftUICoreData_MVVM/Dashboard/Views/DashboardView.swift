//
//  Dashboard.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import SwiftUI
import CoreData

struct DashboardView: View {
  /// required for fetches
  @Environment(\.managedObjectContext) private var viewContext

  /// although the fetchRequest stays in the view, the configuration
  /// of the fetch request can be moved to the view model
  @FetchRequest(fetchRequest: Player.fetch(), animation: .default)


  /// fetched results must stay in the View file for
  /// the Pubishers to function properly
  private var players: FetchedResults<Player>
  
  let viewModel: DashboardViewModel
  
  init() {
    viewModel = DashboardViewModel(dataManager: CoreDataManager.shared)
  }
  
  @FetchRequest(fetchRequest: Game.fetch(), animation: .default)
  private var games: FetchedResults<Game>
  
  var body: some View {
    NavigationView {
      ZStack {
        PrimaryBackgroundView()
        VStack {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(players) { player in
                NavigationLink {
                  PlayerDetailsView(player: player)
                } label: {
                  PlayerCardView(player: player)
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                }
              }
            }
          }
          .frame(height: PlayerCardView.height)
          .padding(.vertical, 20)
          if games.isEmpty {
            VStack(spacing: 8) {
              Image(systemName: "gamecontroller")
                .font(.system(size: 28))
              Text("No Games Played")
                .bold()
            }
            .foregroundColor(.bluesClues.opacity(0.6))
            .frame(maxHeight: .infinity)
          } else {
            VStack {
              Text("Top Games")
                .foregroundColor(.bluesClues.opacity(0.7))
                .bold()
              List {
                ForEach(games) { game in
                  Text("• \(game.title)")
                    .foregroundColor(.bluesClues.opacity(0.9))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
              }
              .listStyle(.plain)
              .background(
                LinearGradient(colors: [.clear, .seafoam.opacity(0.2)],
                               startPoint: .center,
                               endPoint: .bottom)
              )
            }
          }
          HStack(spacing: 20) {
            Button {
              addGame()
            } label: {
              HStack {
                Image(systemName: "plus")
                  .font(.system(size: 16, weight: .bold))
                Text("Game")
                  .bold()
              }
              .foregroundColor(.textPrimary)
              .padding()
            }
            .buttonStyle(.shadedPill)
            NavigationLink {
              PlayerDetailsView()
            } label: {
              HStack {
                Image(systemName: "plus")
                  .font(.system(size: 16, weight: .bold))
                Text("Player")
                  .bold()
              }
              .foregroundColor(.textPrimary)
              .padding()
            }
            .buttonStyle(.shadedPill)
          }
          .padding()
        }
      }
      .navigationTitle("CoreData MVVM")
    }
  }
  
  private func addGame() {
    withAnimation {
      viewModel.addGame(title: "New Game \(games.count + 1)")
    }
  }
  
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
      return DashboardView()
        .environment(
          \.managedObjectContext,
           CoreDataManager.mockDashboardDataManager.container.viewContext
        )
    }
}
