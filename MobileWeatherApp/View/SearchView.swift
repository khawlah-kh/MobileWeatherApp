//
//  ContentView2.swift
//  WeatherApp3
//
//  Created by khawlah khalid on 20/12/2021.
//

import SwiftUI

struct SearchView: View {
    @StateObject var forecastViewModel = ForecastListViewModel()
    @State var isLocationEmpty = false
    var body: some View {
        NavigationView{
            ZStack(alignment:.top){
                LinearGradient(gradient:
                                  Gradient(colors: [ .blue,.white]),
                                     startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
              
                        .edgesIgnoringSafeArea(.all)
                ZStack{
        VStack{
            HStack(spacing:-12){
                TextField("Enter Location", text:$forecastViewModel.location
                          //When user press return
                          ,onCommit: { forecastViewModel.getWeatherForecast() })
                    .padding(5)
                    .overlay(
                         RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                     )
                    .padding()
                    .overlay(
                        Button(action: {
                            forecastViewModel.location=""
                            forecastViewModel.getWeatherForecast()
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.white)
                                .padding(.trailing,5)
                        })
                         .padding(.horizontal)
                        ,alignment: .trailing
                    
                    )
                Button {
                    
                    forecastViewModel.getWeatherForecast()
                    if forecastViewModel.location.isEmpty{
                        isLocationEmpty.toggle()
                    }
                   
                } label: {
                   Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title)
                        .padding()
                }
                
                
            }
            
  
         
                if !forecastViewModel.forecasts.isEmpty
                {
                    VStack{
                   
                    CityName(cityName:forecastViewModel.location )
                       
                        TodayWeatherView(todayWeather: forecastViewModel.forecasts[0])
                        
                        
                        ScrollView{
                            VStack{
                      
                            
                            WeatherDayView(weather: forecastViewModel.forecasts[1])
                            WeatherDayView(weather: forecastViewModel.forecasts[2])
                            WeatherDayView(weather: forecastViewModel.forecasts[3])
                            WeatherDayView(weather: forecastViewModel.forecasts[4])
                            
                            WeatherDayView(weather: forecastViewModel.forecasts[5])
                            WeatherDayView(weather: forecastViewModel.forecasts[6])
                            WeatherDayView(weather: forecastViewModel.forecasts[7])
                            
                            
                        }
                        }
                        
                        
                        
                       
                        
                        }
                }
        }

            
            
        }
        .navigationBarTitle("Search")
        .alert(item: $forecastViewModel.appError) { error in
            Alert(title: Text("Error"), message:Text("""
                   \(error.errorString)
                   Please, try agail later
                   """))
                
            
        }
        .alert(isPresented:$isLocationEmpty) {
            Alert(title: Text("Ops!"), message:Text(
                  " Please, enter a location "))

        }
            
                if forecastViewModel.isLoading{
                  loadingView
                }
        }
        
        
    }
    }
    
    var loadingView : some View{

      
       
            VStack{
                Spacer()
                ProgressView("Fetching Weather")
                    .foregroundColor(Color(.label))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                   .fill(Color(.systemBackground)
                            .opacity(0.1)))
                .padding()
                .shadow(radius: 5)
                Spacer()
                Spacer()
                
            
                
            
        }
        
  
    }

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct CityName: View {
    
    
    var cityName:String
    var body: some View {
        Text(cityName)
            .font(.system(size: 35, weight: .medium))
            .foregroundColor(Color(.label))
            .padding(.horizontal)
    }
}

struct TodayWeatherView: View {

    
    let todayWeather : Daily
    var body: some View {
        VStack( spacing: 1){
            
    
            Text("\( todayWeather.avgTemp)°")
                .font(.system(size: 70))
                .foregroundColor(Color(.label))
                .padding(.leading)
            HStack{
                Text("\(todayWeather.overview )")
            Image(systemName: todayWeather.SFSymbol)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 30 , height: 30)

            }
           // .padding()
            
            HStack{
                Text("\(todayWeather.high) \(todayWeather.low)")
                    .foregroundColor(Color(.label))
                
            }
            .padding()
            
        }
     }
}

struct WeatherDayView: View {
    

    var weather : Daily
    
    var body: some View {
        HStack{
            
            Text(weather.day)
               // .padding(.horizontal)
                .foregroundColor(Color(.label))
                .font(.system(size: 20, weight: .medium))
                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/30, alignment:.leading)
                //.border(Color.blue, width: 1)
            
               
            Image(systemName: weather.SFSymbol)
                .renderingMode(.original)
                .resizable()
                //.foregroundColor(Color(.label))
                .aspectRatio(contentMode: .fit)
                .scaledToFit()
               // .frame(width: 30 , height: 30)
                .frame(width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.height/30, alignment:.leading)
              //  .border(Color.blue, width: 1)
            HStack{
            Text("\(weather.highInt)")
                .font(.system(size: 20, weight: .medium, design: .default))
                .foregroundColor(Color(.label))
                .padding(.trailing)
            
            Text("\(weather.lowInt)")
                .font(.system(size: 20, weight: .medium, design: .default))
                .foregroundColor(Color(.systemGray))
            }
            .frame(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/30)
           // .border(Color.blue, width: 1)
        }
        .padding(.vertical,UIScreen.main.bounds.height/300)
    }
}
