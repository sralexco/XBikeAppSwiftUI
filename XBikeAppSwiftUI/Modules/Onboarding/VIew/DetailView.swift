//
//  DetailView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

struct DetailView: View {
    var onboardingStep: StepOnboardingModel
    var index: Int
    var body: some View {
        VStack {
            Image(onboardingStep.image).resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
               
            Text(onboardingStep.title).bold()
                .font(.title)
                .multilineTextAlignment(.center)
        }
        .id(index)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        .animation(.linear, value: index)
        .frame(maxWidth: .infinity)
     
    }
}
