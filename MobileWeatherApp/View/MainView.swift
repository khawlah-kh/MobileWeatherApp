//
//  MainView.swift
//  WeatherApp3
//
//  Created by khawlah khalid on 11/12/2021.
//


// test 
import SwiftUI
import CoreLocation
import SwiftUI

struct MainView: View {
    
    @StateObject var mainViewModel = MainViewModel()
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
                        
                        
                        
                        
                        if !mainViewModel.forecasts.isEmpty
                        {
                            VStack{
                                
                                VStack{
                                    CityName(cityName:mainViewModel.location )
                                    
                                    
                                    TodayWeatherView(todayWeather: mainViewModel.forecasts[0])
                                }
                                .padding()
                                
                                ScrollView{
                                    VStack{
                                        
                                        
                                        WeatherDayView(weather: mainViewModel.forecasts[1])
                                        WeatherDayView(weather: mainViewModel.forecasts[2])
                                        WeatherDayView(weather: mainViewModel.forecasts[3])
                                        WeatherDayView(weather: mainViewModel.forecasts[4])
                                        
                                        WeatherDayView(weather: mainViewModel.forecasts[5])
                                        WeatherDayView(weather: mainViewModel.forecasts[6])
                                        WeatherDayView(weather: mainViewModel.forecasts[7])
                                        
                                        
                                    }
                                }
                                
                                
                            }
                        }
                        else{
                            Text("empty")
                            
                        }
                    }
                    
                    
                    
                }

                .navigationBarTitle("My Location")
                .alert(item: $mainViewModel.appError) { error in
                    Alert(title: Text("Error"), message:Text("""
                   \(error.errorString)
                   Please, try agail later
                   """))
                    
                    
                }
                .alert(isPresented:$isLocationEmpty) {
                    Alert(title: Text("Ops!"), message:Text(
                        " Please, enter a location "))
                    
                }
                
                if mainViewModel.isLoading{
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




