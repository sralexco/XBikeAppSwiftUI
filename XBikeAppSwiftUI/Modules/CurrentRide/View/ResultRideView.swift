//
//  ResultRideView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//
import SwiftUI

struct ResultRideView: View {
    @ObservedObject var VM: CurrentRideViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Your time was")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.top, 26)
                Text(VM.finalTimerString)
                    .foregroundColor(.black)
                    .font(.system(size: 36, weight: .medium))
                    .padding(.top, 4)
                Text("Distance")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.top, 1)
                Text(VM.distance)
                    .foregroundColor(.black)
                    .font(.system(size: 36, weight: .medium))
                    .padding(.top, 1)
                HStack() {
                    Spacer()
                    Button(action: storeAction,
                           label: { Text("STORE")
                            .font(.system(size: 18, weight: .medium))
                            })
                           
                        .tint(Color.orangeOne)
                    Spacer()
                    Rectangle()
                        .frame(width: 2, height: 36)
                        .foregroundColor(Color.orangeOne)
                    Spacer()
                    Button(action: deleteAction,
                           label: { Text("DELETE")})
                           .font(.system(size: 18, weight: .medium))
                        .tint(Color.grayOne)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.bottom, 36)
                
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
    
    private func storeAction(){
        VM.storeAction()
    }
    
    private func deleteAction(){
        VM.deleteAction()
    }
}

