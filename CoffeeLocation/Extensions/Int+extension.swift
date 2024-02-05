//
//  Int+extension.swift
//  CoffeeLocation
//


import Foundation

extension Int {

    func formatDistance() -> String {
        if self < 1000 {
            // Если расстояние меньше 1 км, выводим в метрах с округлением до 10 м
            let roundedDistance = round(Double(self) / 10) * 10
            return "\(Int(roundedDistance)) м"
        } else {
            // Если расстояние больше 950 м, выводим в километрах с округлением до 100 м
            let distanceInKilometers = Double(self) / 1000.0
            let roundedDistance = round(distanceInKilometers * 10) / 10
            return "\(roundedDistance) км"
        }
    }
}
