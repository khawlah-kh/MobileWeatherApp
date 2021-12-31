//
//  File.swift
//  Weather app
//
//  Created by Khawlh on 20/08/2021.
//

import Foundation
struct WeatherDay{
    
    enum Day:String{
        
        case Sunday = "Sun"
        case Monday = "Mon"
        case Tuesday = "Tus"
        case Wednesday = "Wed"
        case Thuresday = "Thu"
        case Friday = "Fri"
        case saturday = "Sat"
        
        
    }

 var dayName:Day
 var imageName: String
 var temperature: Int

    
}
