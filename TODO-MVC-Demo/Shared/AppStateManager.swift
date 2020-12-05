//
//  AppStateManager.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 12/3/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

protocol AppStateManagerProtocol {
    func start(appDelegate: AppDelegateProtocol)
}

class AppStateManager {
    
    // MARK:- AppState Enum
    enum AppState {
        case none
        case auth
        case main
    }
    
    // MARK:- Properties
    var appDelegate: AppDelegateProtocol!
    var mainWindow: UIWindow? {
        return self.appDelegate?.getMainWindow()
    }
    
    var state: AppState = .none {
        willSet(newState){
            switch newState {
            case .auth:
                switchToAuthState()
            case .main:
                switchToMainState()
            default:
                return
            }
        }
    }
    
    // MARK:- Singleton
    private static let sharedInstance = AppStateManager()
    
    class func shared() -> AppStateManager{
        return AppStateManager.sharedInstance
    }
    
    func profileToAuthState() {
        let profileVC = ProfileVC.create()
        profileVC.delegate = self
        let navigationController = UINavigationController(rootViewController: profileVC)
        self.mainWindow?.rootViewController = navigationController
    }
    
    func switchToMainState() {
        let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .purple
        self.mainWindow?.rootViewController = navigationController
    }
    
    func switchToAuthState() {
        let signInVC = SignInVC.create()
        // 4-
        signInVC.delegate = self
        let navigationController = UINavigationController(rootViewController: signInVC)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .purple
        self.mainWindow?.rootViewController = navigationController
    }
    
}

extension AppStateManager: AppStateManagerProtocol{
    func start(appDelegate: AppDelegateProtocol) {
        self.appDelegate = appDelegate
        
        let isLoggedIn = UserDefaultsManager.shared().isLoggedIn
        if isLoggedIn == true{
            if UserDefaultsManager.shared().token != nil{
                self.state = .main
            }
        }else{
            self.state = .auth
        }
    }
}
// 5-
extension AppStateManager: AuthNavigationDelegate {
    func showMainState() {
        self.state = .main
    }
}
extension AppStateManager: MainNavigationDelegate{
    func showAuthState() {
            self.state = .auth
        }
    }
    
    

