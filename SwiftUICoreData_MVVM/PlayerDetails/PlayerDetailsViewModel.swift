//
//  PlayerDetailsViewModel.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/1/22.
//

import CoreData
import Foundation
import SwiftUI

struct PlayerDetailsViewModel: EditViewModel {

  typealias ParentEntity = Player
  typealias TempEntity = Player
  
  /// this is used for deleting onlyx
  internal var parentContextEntity: Player?
  
  var object: Player
  var context: NSManagedObjectContext
  var dataManager: CoreDataManager
  
  init(dataManager: CoreDataManager, player: Player? = nil) {
    /// sets the child context (scratch pad)
    self.context = dataManager.childViewContext()
    if let player = player {
      /// set instance of original for deleting
      self.parentContextEntity = player
      /// sets editing object in child context for use in view
      self.object = dataManager.editingCopy(of: player, in: context)
    } else {
      /// create new player instance
      self.object = dataManager.newTemporaryInstance(in: context)
      self.object.agent = FBIAgent(context: context) /// auto assign FBI Agent 🕵🏻‍♂️
    }
    /// stores CoreDataManager for deleting the model
    self.dataManager = dataManager
  }
  
  func save(with games: [Game]) {
    // save any new games
    let gamesCopy = editingCopy(games: games)
    object.gameList = gamesCopy
    persist()
  }
  
  func remove(game: Game) {
    let games = object.mutableSetValue(forKey: Player.Relationship.games)
    for item in games {
      guard let deleteGame = item as? Game else { continue }
      if deleteGame.objectID.isEqual(game.objectID) {
        games.remove(deleteGame)
        break
      }
    }
  }
  
  private func editingCopy(games: [Game]) -> [Game] {
    return games.map { dataManager.editingCopy(of: $0, in: context) }
  }
  
}

extension PlayerDetailsViewModel {
  
#if DEBUG
/// Creates a mockViewModel to use with previews
/// - Parameter playerName: `name` for mock player. If left empty, default name remains
/// - Returns: `PlayerDetailsViewModel` based on `.empty` CoreDataManager construct
/// - Note:  ⚠️ Do NOT test against this since it bypasses necessary initializations
  static func mockViewModel(params: Any?...) -> PlayerDetailsViewModel {
    let manager = CoreDataManager.empty
    let context = manager.container.viewContext
    let player = Player.example(context: context)
    if let name = params.first as? String, !name.isEmpty {
      player.name = name
    }
    player.agent = FBIAgent(context: context)
    manager.save()
    
    let vm = PlayerDetailsViewModel(dataManager: manager, player: player)
    return vm
  }
  #endif
  
}
