//
//  SwiftUICoreData_MVVMTests.swift
//  SwiftUICoreData_MVVMTests
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import XCTest
@testable import SwiftUICoreData_MVVM

class SwiftUICoreData_MVVMTests: XCTestCase {

  func test_addItem() {
    let context = CoreDataManager.empty.container.viewContext
    let player = Player(context: context)

    XCTAssertNotNil(player.rank_, "rank_ should NOT be nil")
    XCTAssertNotNil(player.name_, "name_ should NOT be nil")
    
    addTeardownBlock { context.delete(player) }
  }
  
  func test_fetch() {
    let context = CoreDataManager.empty.container.viewContext
    let player = Player(context: context)
    
    let request = Player.fetch()
    let players = try? context.fetch(request)
    
    XCTAssert(players?.count == 1, "players were NOT fetched")
    
    addTeardownBlock { context.delete(player) }
  }
  
  func test_gameDelete() {
    let manager = CoreDataManager.empty
    let testingComponents = testingComponents(manager: manager)
    let sut = testingComponents.sut
    let player = testingComponents.player
    
    guard let gamesArr = sut.model.games?.allObjects else {
      XCTFail("🚫 Games should NOT be nil")
      return
    }
    
    let gameCount = gamesArr.count
    print("FirstGameCount:", gameCount)
    XCTAssertGreaterThan(gameCount, 0, "games should NOT be empty")
    guard let game = gamesArr.first as? Game
    else { fatalError("should be Game object") }
    
    // 🧪 removing game
    sut.remove(game: game)
    
    // ☑️ verify working context
    let finalGameCount = sut.model.games?.allObjects.count ?? 0
    print("FinalGameCount:", finalGameCount)
    XCTAssertLessThan(
      finalGameCount,
      gameCount,
      "🚫 Game should have been removed"
    )
    
    // ☑️ verify parent(main) context
    let persistedGameCount = player.games?.allObjects.count ?? 0
    print("PersistedGameCount", persistedGameCount)
    XCTAssertGreaterThan(
      persistedGameCount,
      finalGameCount,
      "🚫 Persisted game count should be GREATER THAN working context game count"
    
    )
    
    // required as test class cannot hold instance of PersistenceController
    addTeardownBlock {
      self.delete(player, in: manager)
//      persistenceController.container.viewContext.delete(person)
    }
  }
  
  private func testingComponents(manager: CoreDataManager) -> (sut: PlayerDetailsViewModel, player: Player) {
    let player = Player.example(context: manager.container.viewContext)
    manager.save()
    
    let sut = PlayerDetailsViewModel(
                dataManager: manager,
                player: player)
    return (sut, player)
  }
  
  private func delete<T: NSManagedObject>(_ item: T, in manager: CoreDataManager) {
    manager.container.viewContext.delete(item)
  }

}
