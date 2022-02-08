//
//  DashboardViewModel.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import Foundation

protocol MockableViewModel {
  static func mockViewModel(params: Any?...) -> Self
}

struct DashboardViewModel: AddViewModel {
 
  var context: NSManagedObjectContext
  
  init(dataManager: CoreDataManager) {
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

extension DashboardViewModel: MockableViewModel {
  
  #if DEBUG
  static func mockViewModel(params: Any?...) -> DashboardViewModel {
    let manager = CoreDataManager.empty
    let context = manager.container.viewContext
    
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
    
    let vm = DashboardViewModel(dataManager: manager)
    return vm
  }
  #endif
  
}
