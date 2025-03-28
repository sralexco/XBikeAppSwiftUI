//
//  Ride.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 28/03/25.
//

import SwiftData
import Foundation

@Model
class RideSDModel {
    var finalTime: String
    var startAddress: String
    var endAddress: String
    var distance: String
    var createdAt: Date = Date()
    
    init(finalTime: String, startAddress: String, endAddress: String, distance: String) {
        self.finalTime = finalTime
        self.startAddress = startAddress
        self.endAddress = endAddress
        self.distance = distance
    }
}
