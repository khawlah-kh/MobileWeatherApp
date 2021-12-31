//
//  WeatherButton.swift
//  Weather app
//
//  Created by Khawlh on 20/08/2021.
//


import SwiftUI
struct WheatherButton: View {
    
    
    var title:String
    var backgroundColor:Color
    var fontColor:Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold, design: .default))
            .foregroundColor(fontColor)
            .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            .background(backgroundColor)
            
            .cornerRadius(10.0)
    }
}
