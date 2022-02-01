//
//  FBIAgent+.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import CoreData
import Foundation

extension FBIAgent: Model {
  typealias Object = FBIAgent
  
  static let entity = "FBIAgent"
  
  struct Property {
    static let agentID = "agentID_"
    static let name = "name_"
  }
  
  struct Relationship {
    static let myPlayer = "myPlayer"
  }
  
  var agentID: String {
    get { agentID_ ?? "XXX-XXX-XXXX" }
    set { agentID_ = newValue }
  }
  
  var name: String {
    get { name_ ?? "-NAME REDACTED-" }
    set { name_ = newValue }
  }
  
  public override func awakeFromInsert() {
    setPrimitiveValue(String.agentID(), forKey: Property.agentID)
  }
  
  static func fetch() -> NSFetchRequest<FBIAgent> {
    let request = NSFetchRequest<FBIAgent>(entityName: FBIAgent.entity)
    request.sortDescriptors = [NSSortDescriptor(keyPath: \FBIAgent.name_, ascending: false)]
    request.predicate = NSPredicate(format: "TRUEPREDICATE")
    return request
  }
  
  static func example(context: NSManagedObjectContext) -> FBIAgent {
    let agent = FBIAgent(context: context)
    agent.name = "Smith"
    agent.agentID = String.agentID()
    return agent
  }
  
}
