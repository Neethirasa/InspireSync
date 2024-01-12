//
//  InspireSyncApp.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-11.
//

import SwiftUI
import Firebase


@main
struct InspireSyncApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Configured Firebase!")
    return true
  }
}
