//
//  CurrentRideViewModel.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//
import SwiftUI
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
    @Published var isOpenNewTimer = false
    @Published var isInitiated = false
    @Published var isFinished = false
    
    @Published var finalTimerString = "00 : 00 : 00"
    @Published var distance = "0 km"
    @Published var startAddress: String = ""
    @Published var endAddress: String = ""
    @Published var rideModel : RideModel?
    
    @Published var locationManager: LocationManager = LocationManager()
    private let geocoder = GMSGeocoder()
    var modelContext: ModelContext?
    
    init(locationManager: LocationManager = LocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.getAuthorizationLocation()
    }

    //MARK: - Actions
    func addRideAction(){
        if !showResult && !showStore && showTimer != true {
            showTimer = true
            isOpenNewTimer = true
        }
    }
    
    func startPauseAction() {
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
    }
    
    func stopAction() {
        if elapsedTime == 0 {
            return
        }
        timer?.invalidate()
        elapsedTime = 0
        isRunning = false
        finalTimerString = timerString
        timerString = "00 : 00 : 00"
        showTimer = false
        showResult = true
        isFinished = true
    }
    
    func storeAction() {
        Task { @MainActor in
            let success = await saveRideModel()
            if success {
                showResult = false
                showStore = true
            } else {
                showAlert(title: "Error", message: "Try again more Later")
                showResult = false
                showStore = false
            }
         }
    }
    
    func deleteAction() {
        showResult = false
        isOpenNewTimer = true
    }
    
    func finishAction() {
        showStore = false
    }
    
    //MARK: - Functions
    func finishRideLocations(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D) {
        let start = CLLocation(latitude: startLocation.latitude, longitude: startLocation.longitude)
        let end = CLLocation(latitude: endLocation.latitude, longitude: endLocation.longitude)
        let distanceInKM:Double = fabs(start.distance(from: end) / 1000)
        let distanceformatted: String = String(format: "%.2f km", distanceInKM)
        distance = distanceformatted
        rideModel = RideModel(finalTime: finalTimerString, startAddress: "-", endAddress: "-", distance: distanceformatted)
        
        geocoder.reverseGeocodeCoordinate(start.coordinate) { response, error in
           if let address = response?.firstResult() {
                self.startAddress = (address.thoroughfare ?? "") + ", " + (address.locality ?? "")
           }
           else {
                self.startAddress = "-"
           }
           self.rideModel?.startAddress = self.startAddress
        }
        geocoder.reverseGeocodeCoordinate(end.coordinate) { response, error in
           if let address = response?.firstResult() {
                self.endAddress = (address.thoroughfare ?? "") + ", " + (address.locality ?? "")
           }
           else {
                self.endAddress = "-"
           }
            self.rideModel?.endAddress = self.endAddress
        }
    }
    
    //MARK: - Storage Functions
    @MainActor
    func saveRideModel() async -> Bool {
        guard let model = rideModel, let context = modelContext else { return false }
        let newRide = RideSDModel(finalTime: model.finalTime, startAddress: model.startAddress,
                                      endAddress: model.endAddress, distance: model.distance)
        context.insert(newRide)
        return true
     }
    
    //MARK: - Secondary Functions
    func convertTimeToString() {
        let interval = elapsedTime
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        timerString = String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
    
}

//MARK: - LocationManager Authorization
extension CurrentRideViewModel {
    func getAuthorizationLocation() {
        _ = locationManager.manager.authorizationStatus
    }
}
