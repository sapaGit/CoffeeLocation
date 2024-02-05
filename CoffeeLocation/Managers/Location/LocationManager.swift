//
//  LocationManager.swift
//  CoffeeLocation
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager()
    private var completion: ((Result<CLLocationCoordinate2D, Error>) -> Void)?

    override init() {
        super.init()
        setupLocationManager()
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationAuthorization() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation(completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {

        guard locationManager.authorizationStatus == .authorizedWhenInUse else {
            // Request authorization if not granted
            requestLocationAuthorization()
            return
        }

        locationManager.requestLocation()
        self.completion = completion
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        completion?(.success(location))
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            // Handle denied or restricted authorization
            completion?(.failure(NSError(domain: "LocationDenied", code: 0, userInfo: nil)))
        } else if status == .authorizedWhenInUse {
            // If authorization granted, request location again
            locationManager.requestLocation()
        }
    }
}
