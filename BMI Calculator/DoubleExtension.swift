//
//  FloatExtension.swift
//  BMI Calculator
//
//  Created by Kristanto Sean N on 07/04/22.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
