//
//  CurrentRideViewModel.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//
import SwiftUI

class CurrentRideViewModel: BaseViewModel {
    @Published var title = "Current Ride"
    @Published var currentRide = RideState.noInitiated
    
    @Published var showTimer = false
    @Published var showStore = false
    @Published var showResult = false
    
    @Published var isRunning = false
    @Published var elapsedTime: TimeInterval = 0
    @Published private var timer: Timer?
    @Published var timerString = "00 : 00 : 00"
    @Published var finalTimerString = "00 : 00 : 00"
    
    @Published var distance = "10.0 km"
 
    func addRide(){
        if !showResult && !showStore {
            showTimer = true
        }
    }
    
    /// Timer
    func startPause() {
        if isRunning {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.elapsedTime += 1
                self.convertTimeToString()
            }
        }
        isRunning.toggle()
    }
    
    func reset() {
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
    }
    
    func stop() {
        timer?.invalidate()
        isRunning = false
        finalTimerString = timerString
        
        showTimer = false
        showResult = true
    }
    
    func store() {
        showTimer = false
        showResult = false
        showStore = true
    }
    
    func delete() {
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
        timerString = "00 : 00 : 00"
        
        showTimer = true
        showResult = false
    }
    
    func finish(){
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
        timerString = "00 : 00 : 00"
        
        showTimer = false
        showResult = false
        showStore = false
    }
    
    
    func convertTimeToString() {
        let interval = elapsedTime
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        timerString = String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
    
    func getCurrentTimerString() -> String {
        return timerString
    }
    
}


enum RideState {
    case noInitiated
    case initiated
    case ended
}
