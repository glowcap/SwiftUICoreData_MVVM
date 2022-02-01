//
//  Persistence.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData

final class CoreDataManager {
  static let shared = CoreDataManager()
  
  /// for use with unit tests
  static var empty: CoreDataManager = {
    CoreDataManager(inMemory: true)
  }()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "SwiftUICoreData_MVVM")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { [weak self] storeDescription, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
      guard let self = self else { return }
      self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
      self.container.viewContext.automaticallyMergesChangesFromParent = true
    }
  }
  
  func save() {
    let context = container.viewContext
    do {
      try context.save()
    } catch let error {
      fatalError("Unresolved error \(error), \(error.localizedDescription)")
    }
  }
  
  func delete(_ object: NSManagedObject) {
    container.viewContext.delete(object)
  }
  
  static func previewError(_ error: NSError) -> String {
    return "Failed to save inMemory context\n🛑 error: \(error) info: \(error.userInfo)"
  }
  
}

// MARK: Core Data threading rules

/// • Managed Objects can NOT be passed between threads
/// • Managed Objects should only be accessed on their context's queue
/// • The view context runs on the main queue; that is the only context
///   that should be used to fetch objects for the UI
/// • Call `perform` or `performAndWait` on managed object context to
///   run code on its queue

/// Run Scheme argument
/// -com.apple.CoreData.ConcurrencyDebug 1
/// passing this during debugging will crash the app if it catches an error

extension CoreDataManager {
  
  /// scratch pad to **Create** and **Update** or cancel changes without
  /// triggering `ViewContext->FetchRequest->SwiftUI`
  /// - Note: ☝️Child View Context is **NOT ** persisted automatically
  func childViewContext() -> NSManagedObjectContext {
    // create the child context
    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    // assign parent context
    context.parent = container.viewContext
    return context
  }
  
  
  /// Creates a new instance to be used in a `childViewContext`
  /// - Returns: new instance of request `NSManagedObject`
  func newTemporaryInstance<T: NSManagedObject>(in context: NSManagedObjectContext) -> T {
    // more formatting can be done here
    return T(context: context)
  }
  
  /// Creates a clone of an existing `NSManagedObject` to be used in
  /// a `childViewContext`
  /// - Returns: returns a clone of the `NSManagedObject` request
  /// - Note: ⚠️ `objectID` is the only `NSManagedObject` property
  ///         that can be accessed safely across threads
  func editingCopy<T: NSManagedObject>(of object: T, in context: NSManagedObjectContext) -> T {
    guard let object = try? context.existingObject(with: object.objectID) as? T
    else { fatalError("Requested copy of NSManagedObject that does NOT exist") }
    return object
  }
  
  /// Saves `NSManagedObject` up through `childViewContext` if required
  /// - Parameter object: `NSManagedObject` to be saved
  func persist(_ object: NSManagedObject) {
    do {
      // save child context -> view context
      try object.managedObjectContext?.save()
      if let parent = object.managedObjectContext?.parent {
        do {
          // save view context -> persistent store
          try parent.save()
        } catch let error {
          let errDesc = error.localizedDescription
          fatalError(
            "Failed to persist view context to persistent store\n🛑 error: \(errDesc)"
          )
        }
      }
    } catch let error {
      let errDesc = error.localizedDescription
      fatalError(
        "Failed to persist child context to view context\n🛑 error: \(errDesc)"
      )
    }
  }
  
}
