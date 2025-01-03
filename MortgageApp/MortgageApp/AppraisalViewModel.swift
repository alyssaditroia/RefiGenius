//
//  AppraisalViewModel.swift
//  MortgageApp
//
//  Created by Alyssa DiTroia on 10/25/24.
//
import SwiftUI
import MapKit
import CoreLocation

class AppraisalViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var address: String = ""
    @Published var estimatedValue: Double = 0.0
    @Published var comparableHomes: [ComparableHome] = []
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var errorMessage: String?
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func appraiseUsingCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func appraiseUsingAddress(_ inputAddress: String) {
        geocoder.geocodeAddressString(inputAddress) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            if let location = placemarks?.first?.location {
                self.updateRegion(location.coordinate)
                self.address = inputAddress
                self.performAppraisal(for: location.coordinate)
            }
        }
    }

    private func performAppraisal(for coordinate: CLLocationCoordinate2D) {
        // Placeholder for estimation logic
        self.estimatedValue = Double.random(in: 200_000...1_000_000)
        self.comparableHomes = generateComparableHomes(near: coordinate)
    }

    private func generateComparableHomes(near coordinate: CLLocationCoordinate2D) -> [ComparableHome] {
        // Generate dummy comparable homes data
        return [
            ComparableHome(
                name: "Comparable Home 1",
                value: "$950,000",
                latitude: coordinate.latitude + 0.01,
                longitude: coordinate.longitude + 0.01
            ),
            ComparableHome(
                name: "Comparable Home 2",
                value: "$980,000",
                latitude: coordinate.latitude - 0.01,
                longitude: coordinate.longitude - 0.01
            ),
            ComparableHome(
                name: "Comparable Home 3",
                value: "$1,020,000",
                latitude: coordinate.latitude + 0.015,
                longitude: coordinate.longitude - 0.015
            )
        ]
    }

    private func updateRegion(_ coordinate: CLLocationCoordinate2D) {
        self.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }

    // CLLocationManagerDelegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        default:
            errorMessage = "Location permission denied."
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            updateRegion(location.coordinate)
            reverseGeocode(location)
            performAppraisal(for: location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = error.localizedDescription
    }

    private func reverseGeocode(_ location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            if let placemark = placemarks?.first {
                self?.address = [
                    placemark.subThoroughfare,
                    placemark.thoroughfare,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.postalCode
                ]
                .compactMap { $0 }
                .joined(separator: ", ")
            }
        }
    }
}


