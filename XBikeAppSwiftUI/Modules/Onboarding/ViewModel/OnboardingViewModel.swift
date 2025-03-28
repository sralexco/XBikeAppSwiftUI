//
//  OnboardingViewModel.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

class OnboardingViewModel : ObservableObject {
    @Published var index: Int = 0
    @Published var steps: [StepOnboardingModel] = []
    @Published var isFinished: Bool = false
    @Published var currentStep: StepOnboardingModel? = nil
    
    init(){
       fillSteps()
       UserDefaults.standard.set(true, forKey: "isShowedOnboarding")
    }
    
    private func fillSteps(){
        steps.append(StepOnboardingModel(image: .step1Onboarding, title: "Extremely simple to\nuse"))
        steps.append(StepOnboardingModel(image: .step2Onboarding, title: "Track your time and\ndistance"))
        steps.append(StepOnboardingModel(image: .step3Onboarding, title: "See your progress\nand challenge\nyourself!"))
        currentStep = steps[index]
    }
    
    func nextStep(){
        if index < steps.count - 1 {
            index += 1
            currentStep =  steps[index]
        } else {
            withAnimation (.linear.delay(0.5)){
                isFinished = true
            }
        }
    }
    
}
