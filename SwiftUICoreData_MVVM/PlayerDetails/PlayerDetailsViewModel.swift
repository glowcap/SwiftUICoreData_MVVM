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
  
  var model: Player
  var context: NSManagedObjectContext
  var dataManager: CoreDataManager
  
  init(dataManager: CoreDataManager, player: Player? = nil) {
    /// sets the child context (scratch pad)
    self.context = dataManager.childViewContext()
    if let player = player {
      /// set instance of original for deleting
//      self.parentContextEntity = player
      /// create editing copy for use in view
      self.model = dataManager.editingCopy(of: player, in: context)
    } else {
      /// create new player instance
      self.model = dataManager.newTemporaryInstance(in: context)
    }
    /// stores CoreDataManager for deleting the model
//    self.dataManager = dataManager
    self.dataManager = CoreDataManager.shared
  }

  #if DEBUG
  /// Generates a mock of the Player for use with Previews
  /// The `mock` param is really only there as a note
  /// ⚠️ Do NOT test against this since it bypasses necessary initializations
  init(mock: Bool) {
    self.model = Player.example(context: CoreDataManager.empty.container.viewContext)
    self.dataManager = CoreDataManager.empty
    self.context = CoreDataManager.empty.container.viewContext
  }
  #endif
  
  func remove(game: Game) {
    let games = model.mutableSetValue(forKey: Player.Relationship.games)
    for item in games {
      guard let deleteGame = item as? Game else { continue }
      if deleteGame.objectID.isEqual(game.objectID) {
        games.remove(deleteGame)
        break
      }
    }
  }
  
}
