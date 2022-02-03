//
//  EditViewModelProtocol.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/1/22.
//

import CoreData
import Foundation

protocol EditViewModel {
  /// used for deleting the entity
  associatedtype ParentEntity: NSManagedObject
  /// the editing copy of the entity
  /// - Note: ParentEntity and TempEntity **must** match
  associatedtype TempEntity: NSManagedObject
  
  /// working copy of the entity
  var model: TempEntity { get set }
  
  /// child context (scratch pad)
  var context: NSManagedObjectContext { get }
  
  /// original entity - used for deletion
  var parentContextEntity: ParentEntity? { get set }
  
  var dataManager: CoreDataManager { get }
  
  func persist()
  func delete()
}

extension EditViewModel {
  
  /// saves the changes up through to the parent context
  func persist() {
    CoreDataManager.shared.persist2(model)
  }
  
  /// leverages the stored original entity for easy deletion
  func delete() {
    guard let modelToDelete = parentContextEntity else { return }
    dataManager.delete(modelToDelete)
    dataManager.save()
  }
  
}
