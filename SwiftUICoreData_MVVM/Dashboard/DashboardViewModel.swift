//
//  DashboardViewModel.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import Foundation

struct DashboardViewModel: AddViewModel {
  
  var dataManager: CoreDataManager
  var context: NSManagedObjectContext
  
  init(dataManager: CoreDataManager) {
    self.dataManager = dataManager
    /// this is overkill in this particular situation, but could be useful
    /// in other cases
    self.context = dataManager.childViewContext()
  }

  func addGame(title: String) {
    let game = Game(context: context)
    game.title = title
    persist(game)
  }

}

extension CoreDataManager {
  
  static var mockDashboardDataManager: CoreDataManager {
    let manager = CoreDataManager.empty
    let context = manager.container.viewContext
        
    let games = Game.exampleSet(context: context)

    try! context.save()
    
//    for i in 0..<15 {
//      let player = Player(context: context)
//      player.name += "\(i)"
//    }
    
//
//    let player = Player.example(context: context)
//    player.name = "Testing"
//    player.rank = 99
//    try! context.save()
    
    try! context.save()

    return manager
  }
  
}
