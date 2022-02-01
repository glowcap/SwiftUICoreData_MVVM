//
//  String+.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import Foundation

extension String {

  static func agentID() -> String {
    return UUID().uuidString.components(separatedBy: "-").first ?? ""
  }
  
}
