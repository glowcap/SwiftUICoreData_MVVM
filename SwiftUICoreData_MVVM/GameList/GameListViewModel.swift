//
//  GameListViewModel.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/24/22.
//

import CoreData
import Foundation

final class GameListViewModel: ObservableObject {

  @Published var selectedGames = [Game]()
  
  var player: Player
  
  private let context: NSManagedObjectContext
  
  init(player: Player, inContext context: NSManagedObjectContext) {
    self.player = player
    self.context = context
    self.selectedGames = player.gameList
  }
  
  func selection(_ game: Game) {
    let gameCopy = CoreDataManager.shared.editingCopy(of: game, in: context)
    if selectedGames.contains(gameCopy) {
      remove(gameCopy)
    } else {
      add(gameCopy)
    }
  }
  
  private func add(_ game: Game) {
    selectedGames.append(game)
  }
  
  private func remove(_ game: Game) {
    selectedGames = selectedGames.filter { $0 != game }
  }
  
  func game(_ game: Game, inList list: [Game]) -> Bool {
    let idList = list.map { $0.objectID }
    return idList.contains(game.objectID)
  }
  
  func updatePlayerSelections() {
    player.gameList = selectedGames
  }
  
}
