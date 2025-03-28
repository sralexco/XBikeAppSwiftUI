//
//  MyProgressView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 28/03/25.
//

import SwiftUI
import SwiftData

struct MyProgressView : View {
    @ObservedObject private var VM = MyProgressViewModel()
    @Query var rides: [RideSDModel]
    
    var body: some View {
        VStack {
            NavigationBar(title: VM.title )
                .frame(height: 48)
            List(rides, id: \.id) { ride in
                ItemMyProgressView(ride: ride)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
    }
}
