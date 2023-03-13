//
//  WeatherManager.swift
//  Clima


import Foundation
import CoreLocation


protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager:WeatherManager,weather:WeatherModel)
    func didFailWithError(error:Error)
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=00d786785fb2e6986f5afb40ff78e8ff&units=metric"
    
    var delegate:WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with:urlString)
    }
    
    func fetchWeather(latitude:CLLocationDegrees,longitude:CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString:String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task=session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    let weather = self.parseJSON(weatherData:safeData)
                    delegate?.didUpdateWeather(self, weather:weather!)
                }
            }
                task.resume()
            }
        }
    
    func parseJSON(weatherData:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp=decodedData.main.temp
            let name=decodedData.name
            
            let weather=WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            print(weather.conditionName)
            
        }
                catch{
                    delegate?.didFailWithError(error: error)
                    return nil
                }
        
    }
   
    
        
        
    }
    
