//
//  XBikeAppSwiftUIApp.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI
import SwiftData

@main
struct XBikeAppSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: RideSDModel.self)
    }
}
