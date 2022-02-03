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
  
  struct Property {
    static let name = "name_"
    static let rank = "rank_"
  }
  
  /// Relationship struct again limits typos when referencing
  struct Relationship {
    static let games = "games"
    static let fbiAgent = "agent"
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
  
  public override func awakeFromInsert() {
    setPrimitiveValue("New Player", forKey: Property.name)
  }
  
  static func fetch() -> NSFetchRequest<Player> {
    let request = NSFetchRequest<Player>(entityName: Player.entity)
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Player.name_, ascending: false)]
    request.predicate = NSPredicate(format: "TRUEPREDICATE")
    return request
  }
  
  static func example(context: NSManagedObjectContext) -> Player {
    let player = Player(context: context)
    player.name = "xX_L337N05c0p3_Xx"
    player.rank = 1
    player.agent = FBIAgent.example(context: context)
    player.games = Set(Game.exampleSet(context: context)) as NSSet
    return player
  }
  
}
