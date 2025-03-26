//
//  NextButtonView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

struct NextButtonView: View {
    @State var show = false
    @Binding var index: Int
    var action:() -> Void
    var body: some View {
        ZStack{
            Group{
                Circle()
                    .frame(width: 300, height: 300)
                Circle()
                    .frame(width: 230, height: 230)
            }
            .foregroundStyle(.yellow)
            .opacity(0.15)
            Image(systemName: "arrow.right")
                .font(.largeTitle)
                .offset(x: -92, y: -40)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing)
        .offset(x: 150, y: 150).scaleEffect(show ? 1 : 0, anchor: .bottomTrailing)
        .onTapGesture {
            action()
        
        }
        .onChange(of: index) { oldValue, newValue in
            show.toggle()
            withAnimation(.linear(duration: 0.5)){
                show.toggle()
            }
        }
        .onAppear(){
            withAnimation {
                show.toggle()
            }
        }
        
    }
}
