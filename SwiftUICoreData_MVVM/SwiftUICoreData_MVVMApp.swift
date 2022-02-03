//
//  SwiftUICoreData_MVVMApp.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import SwiftUI

@main
struct SwiftUICoreData_MVVMApp: App {
  @Environment(\.scenePhase) var scenePhase
  
  let coreDataManager = CoreDataManager.shared
  
  var body: some Scene {
    WindowGroup {
      DashboardView()
        .environment(\.managedObjectContext, coreDataManager.container.viewContext)
    }
    .onChange(of: scenePhase) { phase in
      guard phase == .background else { return }
      /// save on backgrounding
      // dataManager.save()
    }
  }
  
}
