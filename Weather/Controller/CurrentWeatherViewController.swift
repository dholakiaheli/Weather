//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by Heli Dholakia on 7/2/20.
//  Copyright © 2020 Heli Dholakia. All rights reserved.
//

import UIKit

let APIKey = "bb15dc0d441f171472c0b3dd70b3fb7c"


class CurrentWeatherViewController: UIViewController {
    var lat : Double?
    var long : Double?
    @IBOutlet weak var feelslike: UILabel!
    @IBOutlet weak var temp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
            
    }
    
    func getCurrentWeather(){

        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat ?? 0.0)&lon=\(long ?? 0.0)&appid=\(APIKey)") else {
          return
        }
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return}
               do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                print(jsonResult)
                DispatchQueue.main.async {
                    
                    if let mainobj = jsonResult?["main"] as? NSDictionary {
                        if let tempValue = mainobj["feels_like"] as? Double {
                            self.feelslike.text = "Feels Like: \(tempValue)"
                        }
                        if let humidity = mainobj["humidity"] as? Double {
                            self.temp.text = "Humidity: \(humidity)"
                        }
                    }
                    

                }
               }
                catch{}
            }
            task.resume()
        }
        // Do any additional setup after loading the view.
    }



