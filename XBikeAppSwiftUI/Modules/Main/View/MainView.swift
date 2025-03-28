//
//  MainView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 28/03/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var VM = MainViewModel()
    
    var body: some View {
        if !VM.isShowedOnboarding {
            OnboardingView()
        } else {
            HomeView()
        }
    }
}
