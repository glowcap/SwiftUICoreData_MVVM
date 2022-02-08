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
      /// setting an environment object for view context
      /// is no longer needed as we need access to CoreDataManger
      /// and trying to access the environment object on init throws
      /// a "variabled used before init" error
//        .environment(\.managedObjectContext, coreDataManager.container.viewContext)
    }
    .onChange(of: scenePhase) { phase in
      guard phase == .background else { return }
      /// save on backgrounding. Not using this now, but leaving it since it's a good one to remember
      // coreDataManager.save()
    }
  }
  
}
