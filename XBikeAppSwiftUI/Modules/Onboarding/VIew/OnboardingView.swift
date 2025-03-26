//
//  OnboardingView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject var VM = OnboardingViewModel()
    
    var body: some View {
        ZStack{
            if VM.isFinished {
                HomeView()
                    .transition(.move(edge: .trailing))
            } else {
                PageView(VM: VM)
            }
        }
    }
}

struct PageView: View {
    @ObservedObject var VM: OnboardingViewModel

    var body: some View {
        VStack{
            ProgressView(steps: VM.steps.count, index: $VM.index)
            Spacer()
            if let step = VM.currentStep {
                DetailView(onboardingStep: step, index: VM.index)
            }
            Spacer()
        }
        .padding()
        .background(Color.orangeOne)
        NextButtonView(index: $VM.index) {
            VM.nextStep()
        }
    }
}
