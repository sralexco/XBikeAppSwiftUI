//
//  CurrentRideViewModel.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//
import SwiftUI
import CoreLocation
import Combine
import GoogleMaps
import SwiftData

class CurrentRideViewModel: BaseViewModel {
    @Published var title = "Current Ride"
    
    @Published var showTimer = false
    @Published var showStore = false
    @Published var showResult = false
    
    @Published var isRunning = false
    @Published var elapsedTime: TimeInterval = 0
    @Published private var timer: Timer?
    @Published var timerString = "00 : 00 : 00"
   
    @Published var locationManager: LocationManager = LocationManager()
    @Published var isLocationEnabled: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    @Published var locationUpdateStr = ""
    @Published var isFinished = false
    @Published var isInitiated = false
    @Published var isOpenNewTimer = false
    
    // End Locations
    @Published var startLocation = CLLocationCoordinate2D()
    @Published var endLocation = CLLocationCoordinate2D()
    
    private let geocoder = GMSGeocoder()
    
    @Published var finalTimerString = "00 : 00 : 00"
    @Published var distance = "0 km"
    @Published var startAddress: String = ""
    @Published var endAddress: String = ""
    
    var modelContext: ModelContext?
    
    init(locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
        //self.modelContext = modelContext
        super.init()
        self.setupAuthorizationListener()
        self.getAuthorizationLocation()
    }
    
    // Authorization Location
    func setupAuthorizationListener() {
        locationManager.$authorizationStatus         
        .sink { [weak self] status in
            if status == .authorizedWhenInUse {
                self?.isLocationEnabled = true
            }
        }
        .store(in: &cancellables)
    }
    
    func getAuthorizationLocation() {
        _ = locationManager.manager.authorizationStatus
    }
 
    func addRide(){
        if !showResult && !showStore && showTimer != true {
            showTimer = true
            isOpenNewTimer = true
        }
    }
    
    // Timer
    func startPause() {
        isInitiated = true
        if isRunning {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.elapsedTime += 1
                self.convertTimeToString()
            }
        }
        isRunning.toggle()
        isFinished = false
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
        isFinished = true
        
        // Clear All
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
        timerString = "00 : 00 : 00"
    }
    
    func updateLocations(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D) {
        let start = CLLocation(latitude: startLocation.latitude, longitude: startLocation.longitude)
        let end = CLLocation(latitude: endLocation.latitude, longitude: endLocation.longitude)
        let distanceInKM:Double = fabs(start.distance(from: end) / 1000)
        let distanceformatted: String = String(format: "%.2f km", distanceInKM)
        distance = distanceformatted
        
        geocoder.reverseGeocodeCoordinate(start.coordinate) { response, error in
            if let address = response?.firstResult() {
                self.startAddress = (address.thoroughfare ?? "") + ", " + (address.locality ?? "")
           }
           else {
                self.startAddress = "Not found"
           }
        }
        geocoder.reverseGeocodeCoordinate(end.coordinate) { response, error in
            if let address = response?.firstResult() {
                self.endAddress = (address.thoroughfare ?? "") + ", " + (address.locality ?? "")
           }
           else {
                self.endAddress = "Not found"
           }
        }
        // distance, startAddress, endAdrress, finalTimerString
    }
    
    func store() {
        saveRideModel()
        showTimer = false
        showResult = false
        showStore = true
    }
    
    func saveRideModel() {
        let newRide = RideSDModel(finalTime: finalTimerString, startAddress: startAddress,
                                  endAddress: endAddress, distance: distance)
        modelContext?.insert(newRide)
     }
    
    func delete() {
        showTimer = false
        showResult = false
        isOpenNewTimer = true
    }
    
    func finish(){
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
