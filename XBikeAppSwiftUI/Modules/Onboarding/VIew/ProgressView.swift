//
//  ProgressView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

struct ProgressView: View {
    var steps:Int
    @Binding var index:Int
    var body: some View {
        HStack{
            ForEach(0..<steps,id:\.self) { item in
                GeometryReader { geo in
                    ZStack(alignment:.leading){
                        Capsule()
                            .frame(width: geo.size.width, height: 5)
                            .foregroundStyle(.gray.opacity(0.15))
                        Capsule()
                            .frame(width:index >= item ? geo.size.width : 0, height: 5)
                            .foregroundStyle(.yellow.opacity(0.5))
                            .animation(.easeInOut, value: index)
                    }
                }
            }
        }
        .frame(height: 6)
    }
}
