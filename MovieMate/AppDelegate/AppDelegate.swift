//
//  AppDelegate.swift
//  MovieMate
//
//  Created by Yasir on 16/09/23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = ColorConstants.textPrimary
        navigationBarAppearance.barTintColor = ColorConstants.backgroundPrimary
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: ColorConstants.textPrimary]
        
        if let backButtonImage = UIImage(named: "Back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -8, bottom: 8, right: 0)) {
            navigationBarAppearance.backIndicatorImage = backButtonImage
            navigationBarAppearance.backIndicatorTransitionMaskImage = backButtonImage
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
