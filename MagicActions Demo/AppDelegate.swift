//
//  AppDelegate.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 20/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit
import MagicActions

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        MagicActions.registerDefaults = true
        
        return true
    }


}

