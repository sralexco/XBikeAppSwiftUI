//
//  CurrentRideView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

struct CurrentRideView: View {
    @StateObject var VM = CurrentRideViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                NavigationBar(title: VM.title, showRight: true, imgRight: "ic_add_NavBar",
                              callbackRight: { VM.addRide() })
                    .frame(height: 60)
                Spacer()
            }
            TimerRideView(VM:VM)
                .opacity(VM.showTimer ? 1 : 0)
            ResultRideView(VM:VM)
                .opacity(VM.showResult ? 1 : 0)
            StoredRideView(VM:VM)
                .opacity(VM.showStore ? 1 : 0)
           
            Text("")
            Spacer()
            Spacer()
            
        }.background(.gray)
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
    }
    
    
    
}




