//
//  DashboardViewModel.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import Foundation

struct DashboardViewModel {
  
  let dataManager: CoreDataManager
  
  /// since the Dashboard is only Creating and Deleting
  /// using the main view context is fine here
  var context: NSManagedObjectContext {
    dataManager.container.viewContext
  }
  
  init(coreDataManager: CoreDataManager) {
    self.dataManager = coreDataManager
  }
  
  /// This can be populated as needed
  func addPlayer(name: String) {
    let player = Player(context: context)
    player.name = name
    let agent = FBIAgent(context: context)
    agent.name = String(name.reversed())
    player.agent = FBIAgent.example(context: context)
    
    dataManager.save()
  }
  
  /// since we're only dealing with
  /// the main context, nothing special
  /// needs to be done here
  func delete(player: Player) {
    dataManager.delete(player)
    dataManager.save()
  }
  
}