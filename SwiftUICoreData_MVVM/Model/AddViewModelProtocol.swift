//
//  AddViewModelProtocol.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 2/8/22.
//

import CoreData
import Foundation

protocol AddViewModel {
  
  var dataManager: CoreDataManager { get }
  
  /// child context (scratch pad)
  var context: NSManagedObjectContext { get }
  
  func persist(_ object: NSManagedObject)
  
}

extension AddViewModel {
  
  /// saves the changes up through to the parent context
  func persist(_ object: NSManagedObject) {
    dataManager.persist(object)
  }
  
}
