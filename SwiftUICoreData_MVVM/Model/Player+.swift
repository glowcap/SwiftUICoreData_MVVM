//
//  Player+.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import Foundation

extension Player: Model {
  
  /// assign typealias to NSManagedObject
  typealias Object = Player
  
  /// set entity to entity name to limit typos
  static let entity = "Player"
  
  /// Relationship struct again limits typos when referencing
  struct Relationship {
    static let games = "gameList"
    static let fbiAgent = "myAgent"
  }
  
  /// convenience unwrapped  variable
  var name: String {
    get { name_ ?? "xX_PlayerUnknown_Xx" }
    set { name_ = newValue }
  }
  
  var rank: Int {
    get { Int(rank_) }
    set { rank_ = Int16(newValue) }
  }
  
  static func fetch() -> NSFetchRequest<Player> {
    let request = NSFetchRequest<Player>(entityName: Player.entity)
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Player.rank_, ascending: false)]
    request.predicate = NSPredicate(format: "TRUEPREDICATE")
    return request
  }
  
  static func example(context: NSManagedObjectContext) -> Player {
    let player = Player(context: context)
    player.name = "xX_L337N05c0p3_Xx"
    player.agent = FBIAgent.example(context: context)
    return player
  }
  
}
