//
//  UIApplication+Extension.swift
//  WeatherApp3
//
//  Created by khawlah khalid on 18/12/2021.
//

import UIKit
import Foundation

//Fix issues with keyboard not dismissing and add search field clear button.
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
