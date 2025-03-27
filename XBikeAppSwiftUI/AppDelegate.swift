//
//  AppDelegate.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 27/03/25.
//

import SwiftUI
import GoogleMaps

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCupcjDfVge99cG-KRgiT1UWDLnCtzXbp4")
        return true
    }
}
