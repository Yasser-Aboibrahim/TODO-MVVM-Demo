//
//  AppDelegate.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 10/28/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol AppDelegateProtocol {
    func getMainWindow() -> UIWindow?
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // launch app destination
        AppStateManager.shared().start(appDelegate: self)
        
        return true
    }
}

extension AppDelegate: AppDelegateProtocol {
    func getMainWindow() -> UIWindow? {
        return self.window
    }
}

