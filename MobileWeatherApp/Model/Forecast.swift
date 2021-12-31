//
//  Forecast.swift
//  WeatherApp3
//
//  Created by khawlah khalid on 07/12/2021.
//

import Foundation


struct Forecast  : Codable {
    
    
    struct Daily : Codable{
        
        let dt : Date
        let temp:Temp
        let humidity:Int
        let weather:[Weather]
        let clouds : Int
        let pop : Double

        struct Temp : Codable{
            let min : Double
            let max : Double
            
        }
        struct Weather : Codable{
            let id : Int
            let description : String
            let main : String
    
            var SFSymbol : String {
                
                return iconMap[main] ?? ""
                
            }
            private let iconMap = [
                
                "Drizzle" : "cloud.drizzle.fill",
                "Thunderstorm" : "cloud.bolt.rain.fill",
                "Rain" : "cloud.heavyrain.fill",
                "Snow" : "cloud.snow.fill",
                "Clear" : "sun.max.fill",
                "Clouds" :  "smoke.fill"

            ]

        }

        
    }

    let daily:[Daily]
   
    
}


