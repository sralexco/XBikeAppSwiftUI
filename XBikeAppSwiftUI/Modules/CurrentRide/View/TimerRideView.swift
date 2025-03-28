//
//  TimerRideView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//
import SwiftUI

struct TimerRideView: View {
    @ObservedObject var VM: CurrentRideViewModel
    
    var body: some View {
        VStack{
            Spacer()
            VStack {
                Text(VM.timerString)
                    .foregroundColor(.black)
                    .font(.system(size: 36, weight: .medium))
                    .padding(.top, 40)
                HStack() {
                    Spacer()
                    Button(action: startAction,
                           label: { Text(VM.isRunning ? "PAUSE" : "START")
                            .font(.system(size: 18, weight: .medium))
                            })
                           
                        .tint(Color.orangeOne)
                    Spacer()
                    Rectangle()
                        .frame(width: 2, height: 36)
                        .foregroundColor(Color.orangeOne)
                    Spacer()
                    Button(action: stopAction,
                           label: { Text("STOP")})
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
            .padding(.bottom, 20)
        }
    }
    
    private func startAction(){
        VM.startPause()
    }
    
    private func stopAction(){
        if VM.elapsedTime > 0 {
            VM.stop()
        }
    }
    
}
