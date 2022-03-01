//
//  Game+.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import Foundation

extension Game: Model {

  typealias Object = Game
  
  static let entity = "Game"
  
  struct Relationship {
    static let players = "players"
  }
  
  var title: String {
    get { title_ ?? "Unlisted Game" }
    set { title_ = newValue }
  }
  
  var rating: Int {
    get { Int(rating_) }
    set { rating_ = Int16(newValue) }
  }
  
  var playerList: [Player] {
    get {
      let set = players as? Set<Player> ?? []
      return set.sorted { $0.name < $1.name }
    }
    set { players = NSSet(array: newValue) }
  }
  
  static func fetch() -> NSFetchRequest<Game> {
    let request = NSFetchRequest<Game>(entityName: Game.entity)
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Game.title_, ascending: true)]
    request.predicate = NSPredicate(format: "TRUEPREDICATE")
    return request
  }
  
  static func example(context: NSManagedObjectContext) -> Game {
    let game = Game(context: context)
    game.title = "World of Warhammer 24k"
    return game
  }
  
  static func exampleSet(context: NSManagedObjectContext) -> [Game] {
    var games = [Game]()
    for i in 0..<5 {
      let game = Game.example(context: context)
      game.title += "\(i)"
      games.append(game)
    }
    return games
  }
  
}
