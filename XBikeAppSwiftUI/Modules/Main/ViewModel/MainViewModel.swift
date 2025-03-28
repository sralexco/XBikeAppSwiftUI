//
//  MainViewModule.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 28/03/25.
//

import SwiftUI

class MainViewModel: BaseViewModel {
    @Published var isShowedOnboarding: Bool = false
    
    init(isShowOnboarding: Bool = false){
        super.init()
        self.isShowedOnboarding = isShowedOnboarding
        self.getStateOnboarding()
    }

    func getStateOnboarding(){
        let state = UserDefaults.standard.bool(forKey: "isShowedOnboarding")
        isShowedOnboarding = state
    }
}
