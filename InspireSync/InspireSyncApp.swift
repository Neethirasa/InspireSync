//
//  InspireSyncApp.swift
//  InspireSync
//
//  Created by Nivethikan Neethirasa on 2024-01-11.
//

import SwiftUI
import Firebase
import UIKit
import BackgroundTasks
import WidgetKit


@main
struct InspireSyncApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .defaultAppStorage(UserDefaults(suiteName: "group.Nivethikan-Neethirasa.InspireSync")!)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Configured Firebase!")
      
      // Register for background tasks
              BGTaskScheduler.shared.register(forTaskWithIdentifier: "group.Nivethikan-Neethirasa.InspireSync", using: nil) { task in
                  self.handleAppRefresh(task: task as! BGAppRefreshTask)
              }
      
    return true
  }
    
    func handleAppRefresh(task: BGAppRefreshTask) {
            // Schedule a new refresh task
            scheduleAppRefresh()
            
            // Implement what the background task should do
            // Use WidgetDataManager to update widget data
                WidgetDataManager.shared.updateWidgetData()
            
            // Mark the task as complete
            task.setTaskCompleted(success: true)
        }
        
    func scheduleAppRefresh() {
            let request = BGAppRefreshTaskRequest(identifier: "com.yourcompany.InspireSync.refresh")
            request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60) // Schedule to start at least 1 minute from now
            
            do {
                try BGTaskScheduler.shared.submit(request)
            } catch {
                print("Could not schedule app refresh: \(error)")
            }
        }

        func applicationDidEnterBackground(_ application: UIApplication) {
            // Schedule the background fetch
            scheduleAppRefresh()
        }
        
}

class WidgetDataManager {
    static let shared = WidgetDataManager()

    func updateWidgetData() {
        // Fetch new data and update the widget
        WidgetCenter.shared.reloadAllTimelines()
    }
}
