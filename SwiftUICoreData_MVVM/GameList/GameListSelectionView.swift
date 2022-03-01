//
//  GameListSelectionView.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/21/22.
//

import CoreData
import SwiftUI

struct GameListSelectionView: View {
  @Environment(\.presentationMode) private var presentationMode
  @Environment(\.managedObjectContext) private var viewContext
  @FetchRequest(fetchRequest: Game.fetch(), animation: .default)
  
  private var games: FetchedResults<Game>
        
  @ObservedObject private var viewModel: GameListViewModel
  
  init(for player: Player, in context: NSManagedObjectContext) {
    self.viewModel = GameListViewModel(player: player, inContext: context)
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(games) { game in
          Button {
            viewModel.selection(game)
          } label: {
            HStack {
              Text(game.title)
              if viewModel.game(game, inList: viewModel.selectedGames) {
                Spacer()
                Image(systemName: "checkmark")
              }
            }
          }
        }
      }
      .toolbar {
        Button("Done") {
          viewModel.updatePlayerSelections()
          presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
  
}

//struct GameListSelectionView_Previews: PreviewProvider {
//  static var previews: some View {
//    let game = Game(context: CoreDataManager.empty.container.viewContext)
//    GameListSelectionView(selections: [game])
//  }
//}
