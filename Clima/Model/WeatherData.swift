//
//  WeatherData.swift
//  Clima
//
//  Created by 10683973 on 31/08/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData:Codable{
    let name:String
    let main: Main
    let weather:[Weather]
}
struct Main:Codable{
    let temp:Double
}

struct Weather:Codable{
    let description:String
    let id:Int
}
