//
//  AppDelegate.swift
//  ibeacon-transmitter
//
//  Created by Oscar Silver on 2017-03-07.
//  Copyright © 2017 Sirkl. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    var window: UIWindow?
    
    fileprivate lazy var startVC: UIViewController = iBeaconTransmissionVC(broadcaster: Broadcaster())
}

//MARK: UIApplicationDelegate Methods
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        showGUI()
        return true
    }
}

//MARK: Private Methods
private extension AppDelegate {
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }
    
    func showGUI() {
        window?.rootViewController = startVC
    }
}
