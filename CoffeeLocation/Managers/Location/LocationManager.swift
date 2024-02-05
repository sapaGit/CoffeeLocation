//
//  LocationManager.swift
//  CoffeeLocation
//

import CoreLocation

class LocationManager: NSObject {


    static let shared = LocationManager()

    let manager = CLLocationManager()

    var completion: ((CLLocation) -> Void)?

    public func getUserLocation(completion: @escaping ((CLLocation?) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
