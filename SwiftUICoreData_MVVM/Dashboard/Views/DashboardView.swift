//
//  Dashboard.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import SwiftUI
import CoreData

struct DashboardView: View {
  @Environment(\.managedObjectContext) private var context
  
  /// although the fetchRequest stays in the view, the configuration
  /// of the fetch request can be moved to the view model
  @FetchRequest(fetchRequest: Player.fetch(), animation: .default)


  /// fetched results must stay in the View file for
  /// the Pubishers to function properly
  private var players: FetchedResults<Player>
  
  let viewModel = DashboardViewModel()
  
  @State var dataManager = CoreDataManager.shared
  
  
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
                  PlayerDetailsView(
                    viewModel: viewModel.playerDetailsViewModel(dataManager: dataManager, player: player)
                  )
                } label: {
                  PlayerCard(player: player)
                    .padding(.vertical)
                    .padding(.horizontal, 4)
                }
              }
            }
          }
          .frame(height: PlayerCard.height)
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
            NavigationLink {
//              PlayerDetailsView(viewModel: vm.playerDetailsViewModel())
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
            .frame(maxWidth: .infinity)
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
            NavigationLink {
//              PlayerDetailsView(viewModel: vm.playerDetailsViewModel())
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
            .frame(maxWidth: .infinity)
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
          .padding()
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addPlayer) {
            Label("Add Item", systemImage: "plus")
          }
        }
      }
      .navigationTitle("CoreData MVVM")
      .foregroundColor(.seafoam)
    }
  }
  
  private func addPlayer() {
    withAnimation {
//      viewModel.addPlayer(name: "NewPlayer\(players.count)")
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        let player = players[index]
//        viewModel.delete(player: player)
      }
    }
  }
  
}

/// Configures a preview specifically for DashboardView
/// This has been placed in the DashboardView file for ease
/// of use when manipulating the preview content
extension CoreDataManager {
  
  static var dashboardPreviewDataManger: CoreDataManager {
    let result = CoreDataManager(inMemory: true)
    let context = result.container.viewContext
    
    for i in 0..<15 {
      let player = Player.example(context: context)
      player.name += String(i)
      player.rank = i
    }
    
    for i in 0..<10 {
      let game = Game.example(context: context)
      game.title += " part \(i + 1)"
    }
    
    do {
      try context.save()
    } catch let error as NSError {
      fatalError(CoreDataManager.previewError(error))
    }
  
    return result
  }
  
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
      DashboardView()
        .environment(
          \.managedObjectContext,
           CoreDataManager.dashboardPreviewDataManger.container.viewContext
        )
    }
}
