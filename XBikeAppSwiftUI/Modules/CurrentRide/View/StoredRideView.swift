//
//  StoredRideView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//
import SwiftUI

struct StoredRideView: View {
    @ObservedObject var VM: CurrentRideViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Spacer()
                Text("Your progress has been\ncorrectly stored!")
                    .font(.system(size: 26, weight: .medium))
                    .multilineTextAlignment(.center)
                HStack() {
                    Spacer()
                    Button(action: okAction,
                           label: { Text("OK")
                            .font(.system(size: 18, weight: .medium))
                          
                            })
                           
                        .tint(Color.orangeOne)
                    Spacer()
                }
                .padding(.top, 44)
                .padding(.bottom, 36)
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 322)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
    
    private func okAction(){
        VM.finish()
    }
    
}
