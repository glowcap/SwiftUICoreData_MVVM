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
    let gamesArr = sut.object.gameList
    
    let gameCount = gamesArr.count
    print("FirstGameCount:", gameCount)
    XCTAssertGreaterThan(gameCount, 0, "games should NOT be empty")
    guard let game = gamesArr.first
    else { fatalError("should be Game object") }
    
    // 🧪 removing game
    sut.remove(game: game)
    
    // ☑️ verify working context
    let finalGameCount = sut.object.gameList.count
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
    }
  }
  
  // MARK: - GameListViewModel
  func test_addGame() {
    let manager = CoreDataManager.empty
    let (playerDetailsVM, player) = testingComponents(manager: CoreDataManager.empty)
    let sut = GameListViewModel(
                player: playerDetailsVM.object,
                inContext: playerDetailsVM.context
    )
    
    // 🧪 VM selectedGames set correctly
    let playerGameStartCount = playerDetailsVM.object.gameList.count
    let sutStartGameCount = sut.selectedGames.count
    XCTAssertEqual(playerGameStartCount, sutStartGameCount,
                   "🚫 selectedGames failed to set correctly")
    
    // 🧪 game added to selectedGames
    let newGame = Game.example(context: playerDetailsVM.context)
    sut.selection(newGame)
    
    let sutAddedGameCount = sut.selectedGames.count
    XCTAssertEqual(sutAddedGameCount, sutStartGameCount + 1,
                   "🚫 Game not added to selectedGames")
    
    // 🧪 game added to Player working copy
    sut.updatePlayerSelections()
    let playerAddedGameCount = sut.player.gameList.count
    XCTAssertEqual(playerAddedGameCount, playerGameStartCount + 1,
                   "🚫 Game not added to selectedGames")
    
    addTeardownBlock {
      self.delete(player, in: manager)
    }
  }
  
  func test_removeGame() {
    let manager = CoreDataManager.empty
    let (playerDetailsVM, player) = testingComponents(manager: CoreDataManager.empty)
    let sut = GameListViewModel(
                player: playerDetailsVM.object,
                inContext: playerDetailsVM.context
    )
    
    // 🧪 VM selectedGames set correctly
    let playerGameStartCount = playerDetailsVM.object.gameList.count
    let sutStartGameCount = sut.selectedGames.count
    XCTAssertEqual(playerGameStartCount, sutStartGameCount,
                   "🚫 selectedGames failed to set correctly")
    
    // 🧪 game removed from selectedGames
    guard let gameToRemove = sut.selectedGames.first else {
      XCTFail("🚫 Failed to find game in selectedGames")
      return
    }
    sut.selection(gameToRemove)
    
    let sutRemovedGameCount = sut.selectedGames.count
    XCTAssertEqual(sutRemovedGameCount, sutStartGameCount - 1,
                   "🚫 Game not removed from selectedGames")
    
    // 🧪 game removed from Player working copy
    sut.updatePlayerSelections()
    let playerRemovedGameCount = sut.player.gameList.count
    XCTAssertEqual(playerRemovedGameCount, playerGameStartCount - 1,
                   "🚫 Game not removed from selectedGames")
    
    addTeardownBlock {
      self.delete(player, in: manager)
    }
  }
  
  private func testingComponents(manager: CoreDataManager) -> (sut: PlayerDetailsViewModel, player: Player) {
    let player = Player.example(context: manager.container.viewContext)
    let agent = FBIAgent.example(context: manager.container.viewContext)
    let games = [Game.example(context: manager.container.viewContext)]
    player.agent = agent
    player.gameList = games
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
