//
//  SwiftUICoreData_MVVMApp.swift
//  SwiftUICoreData_MVVM
//
//  Created by Daymein Gregorio on 1/31/22.
//

import SwiftUI

@main
struct SwiftUICoreData_MVVMApp: App {
  let coreDataManager = CoreDataManager.shared
  @Environment(\.scenePhase) var scenePhase
    
  var body: some Scene {
    WindowGroup {
      DashboardView()
      /// setting an environment object for view context
      /// is still needed for fetches to reach out to Core Data
      /// However, trying to access the environment object on
      /// init throws a "variabled used before init" error
        .environment(\.managedObjectContext, coreDataManager.container.viewContext)
    }
    .onChange(of: scenePhase) { phase in
      guard phase == .background else { return }
      /// save on backgrounding. Not using this now, but leaving it since it's a good one to remember
      // coreDataManager.save()
    }
  }
  
}
