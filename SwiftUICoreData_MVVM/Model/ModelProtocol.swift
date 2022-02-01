//
//  ModelProtocol.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import Foundation

protocol Model: AnyObject {
  /// NSManagedObject that conforms to `Model`.
  associatedtype Object: NSManagedObject
  static var entity: String { get }
  
  /// Creates a fetch request formatted by the conformed object
  /// - Returns: `NSFetchRequest<T>`
  static func fetch() -> NSFetchRequest<Object>
  
  /// Generates an example of the conforming `NSManagedObject`
  /// - Returns: example of `<T: NSManagedObject>` to be used with Previews
  static func example(context: NSManagedObjectContext) -> Object
}
