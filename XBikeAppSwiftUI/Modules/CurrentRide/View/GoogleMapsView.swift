//
//  GoogleMapsView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 27/03/25.
//

import SwiftUI
import GoogleMaps
import Combine

struct GoogleMapsView: UIViewRepresentable {
    @ObservedObject var VM: CurrentRideViewModel
    @StateObject var locationManager = LocationManager()
    private let zoom: Float = 17.0
   
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let latitude:CLLocationDegrees = locationManager.manager.location?.coordinate.latitude ?? 0
        let longitude:CLLocationDegrees = locationManager.manager.location?.coordinate.longitude ?? 0
        let options = GMSMapViewOptions()
        options.camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: zoom)
        let mapView = GMSMapView(options: options)
        mapView.delegate = context.coordinator
        context.coordinator.subscribeToLocationUpdates(for: mapView)
        context.coordinator.subscribeToOpenNewTimer()
        context.coordinator.subscribeToIsInitiated(for: mapView)
        context.coordinator.subscribeToIsFinished(for: mapView)
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        guard let location = locationManager.manager.location else { return }
        let newCamera = GMSCameraPosition.camera(
            withLatitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            zoom: zoom
        )
        mapView.animate(to: newCamera)
    }
    
}

class MapCoordinator: NSObject, GMSMapViewDelegate {
    let parent: GoogleMapsView
    var path = GMSMutablePath()
    var polyline = GMSPolyline()
    var startLocation = CLLocationCoordinate2D()
    var lastLocation = CLLocationCoordinate2D()
    var markers: [GMSMarker] = []
    var cancellables = Set<AnyCancellable>()
    
    init(parent: GoogleMapsView) {
        self.parent = parent
    }
    
    deinit {
        print("deinit: MapCoordinator")
    }
    
    func subscribeToLocationUpdates(for mapView: GMSMapView) {
        parent.locationManager.$location
            .compactMap { $0 } 
            .sink { newLocation in
                if self.parent.VM.isRunning == true {
                    let coordinate = CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude)
                    self.lastLocation = coordinate
                    self.path.add(coordinate)
                    self.polyline.path = self.path
                    self.polyline.strokeColor = .orange
                    self.polyline.strokeWidth = 5
                    self.polyline.map = mapView
                }
            }
            .store(in: &cancellables)
    }
    
    func subscribeToIsInitiated(for mapView: GMSMapView) {
        parent.VM.$isInitiated
            .receive(on: DispatchQueue.main)
            .filter { $0 }
            .sink { _ in
                self.parent.VM.isInitiated = false
                let lat: CLLocationDegrees = self.parent.locationManager.manager.location?.coordinate.latitude ?? 0
                let lon: CLLocationDegrees = self.parent.locationManager.manager.location?.coordinate.longitude ?? 0
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let marker = GMSMarker()
                marker.position = coordinate
                marker.title = "Start Point"
                marker.snippet = "Point A"
                marker.icon = UIImage(named: "ic_markerStart")?.resized(to: CGSize(width: 30, height: 30))
                marker.map = mapView
                self.markers.append(marker)
                 
                self.startLocation = coordinate
                self.lastLocation = coordinate
                self.path.add(coordinate)
                self.polyline.path = self.path
                self.polyline.strokeColor = .orange
                self.polyline.strokeWidth = 5
                self.polyline.map = mapView
                
            }
            .store(in: &cancellables)
    }
    
    func subscribeToIsFinished(for mapView: GMSMapView) {
        parent.VM.$isFinished
            .receive(on: DispatchQueue.main)
            .filter { $0 }
            .sink { _ in
                self.parent.VM.isFinished = false
                self.parent.VM.finishRideLocations(startLocation: self.startLocation, endLocation: self.lastLocation)
                let marker = GMSMarker()
                marker.position = self.lastLocation
                marker.title = "End Point"
                marker.snippet = "Point B"
                marker.icon = UIImage(named: "ic_markerEnd")?.resized(to: CGSize(width: 30, height: 30))
                marker.map = mapView
                self.markers.append(marker)
            }
            .store(in: &cancellables)
    }
    
    func subscribeToOpenNewTimer() {
        parent.VM.$isOpenNewTimer
            .receive(on: DispatchQueue.main)
            .filter { $0 }
            .sink { _ in
                self.parent.VM.isOpenNewTimer = false
                self.clearMap()
            }
            .store(in: &cancellables)
    }
    
    private func clearMap() {
       for marker in markers {
           marker.map = nil
       }
       markers.removeAll()
       path = GMSMutablePath()
       polyline.map = nil
       polyline = GMSPolyline()
       polyline.strokeColor = .orange
       polyline.strokeWidth = 5
   }
    
}
