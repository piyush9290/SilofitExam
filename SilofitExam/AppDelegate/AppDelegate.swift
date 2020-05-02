//
//  AppDelegate.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var mainWindow: UIWindow?
    var appInitialier: AppInitializer?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        mainWindow = window
        appInitialier = AppInitializer(window: window)
        appInitialier?.start()
        return true
    }
}

