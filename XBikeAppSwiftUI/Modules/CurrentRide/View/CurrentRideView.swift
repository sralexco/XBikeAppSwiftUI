//
//  CurrentRideView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

struct CurrentRideView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var VM = CurrentRideViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBar(title: VM.title, showRight: true, imgRight: "ic_add_NavBar",
                              callbackRight: { VM.addRideAction()} )
                    .frame(height: 48)
                GoogleMapsView(VM: VM)
                    .padding(.top, 0)
            }
            TimerRideView(VM:VM)
                .opacity(VM.showTimer ? 1 : 0)
            ResultRideView(VM:VM)
                .opacity(VM.showResult ? 1 : 0)
            StoredRideView(VM:VM)
                .opacity(VM.showStore ? 1 : 0)
        }
        .onAppear { VM.modelContext = modelContext }
        .background(.clear)
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
    }
}
