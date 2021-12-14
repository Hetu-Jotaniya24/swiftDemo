//
//  AppDelegate.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 10/11/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(APIEnvironment.baseURL)
        setupApplication()
        return true
    }

}

//==================
//MARK: APP UI Setup
//==================

extension AppDelegate {
    
    func setupApplication(){
       
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.previousNextDisplayMode = .default
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        
        if #available(iOS 13, *) {
            window?.overrideUserInterfaceStyle = .light
        }
    }
  
    func setupTransparentNavigationBar() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
        
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font:UIFont(name: FontBook.semibold.rawValue, size: 25)!]
        
        //Remove back button title "Back"
        let navBarButtonAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        navBarButtonAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0.1), NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
}

