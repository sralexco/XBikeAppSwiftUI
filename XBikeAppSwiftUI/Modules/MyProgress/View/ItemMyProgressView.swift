//
//  ItemMyProgressView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 28/03/25.
//
import SwiftUI

struct ItemMyProgressView: View {
    var ride: RideSDModel
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray).opacity(0.5)
                .frame(maxWidth: .infinity)
                .frame(height: 0.5)
                .padding(.top, 0)
        
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(ride.finalTime)
                        .padding(.top, 0)
                        .padding(.leading, 12)
                        .font(.system(size: 30, weight: .regular))
                        .foregroundColor(.blackOne)
                    
                    Text(ride.startAddress)
                        .padding(.top, 4)
                        .padding(.leading, 12)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.grayTwo)
                    
                    Text(ride.endAddress)
                        .padding(.top, 4)
                        .padding(.leading, 12)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.grayTwo)
                    
                    Spacer(minLength: 0)
                }
                Spacer()
                Text(ride.distance)
                    .padding(.trailing, 12)
                    .font(.system(size: 26, weight: .regular))
                    .foregroundColor(.blackOne)
                
            }
            .background(.white)
            .padding(.top, 10)
            .padding(.bottom, 20)
        }
        .background(.white)
    }
}
