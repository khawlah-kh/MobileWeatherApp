
import Foundation

//consedered as a second layer of decoding


// Represents Daily after adjustments.
struct Daily {
    let forecast: Forecast.Daily
    var system : Int
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "E, MMM, d"
        dateFormatter.dateFormat = "E"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    var day: String {
        return days[Self.dateFormatter.string(from: forecast.dt)] ?? Self.dateFormatter.string(from: forecast.dt)
    }
    
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    var high: String {
        return "H: \(Self.numberFormatter.string(for: convert(forecast.temp.max)) ?? "0")°"
    }
    
    var low: String {
        return "L: \(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0")°"
    }
    
    
    var highInt: Int {
        return Int(convert(forecast.temp.max))
    }
    
    var lowInt: Int {
        return Int(convert(forecast.temp.min))
    }
    
    
    
    
    
    var avgTemp: String {
        
        Self.numberFormatter.string(for: convert((forecast.temp.min+forecast.temp.max)/2))  ?? "0"
    }
    var pop: String {
        return "💧 \(Self.numberFormatter2.string(for: forecast.pop) ?? "0%")"
    }
    
    var clouds: String {
        
        return "☁️ \(forecast.clouds)%"
    }
    
//    var humidity: String {
//        return "\(forecast.humidity)°"
//    }
    var humidity: String {
        return "Humidity: \(forecast.humidity)%"
    }
    
    
    var SFSymbol : String {
        
        return iconMap[forecast.weather[0].main] ?? ""
        
    }
    private let iconMap = [
        
        "Drizzle" : "cloud.drizzle.fill",
        "Thunderstorm" : "cloud.bolt.rain.fill",
        "Rain" : "cloud.heavyrain.fill",
        "Snow" : "cloud.snow.fill",
        "Clear" : "sun.max.fill",
        "Clouds" :  "smoke.fill"

    ]
    private let days = [
        
        "Sat" : "Saturday",
        "Sun" : "Sunday",
        "Mon" : "Monday",
        "Tue" : "Tuesday",
        "Wed" : "Wednesday",
        "Thu" :  "Thuresday",
        "Fri":"Friday"

    ]
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
}


