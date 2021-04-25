//
//  NetworkManager.swift
//  Stock App
//
//  Created by Massive Infinity on 21/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    var intradayData: [IntradayData] = []
    
    func fetchIntraday(symbol: String, interval: Int, outputSize: String, completionHandler: @escaping (APIData) -> Void) {
        guard let url = URL(string: Constants.API.BaseURL + Constants.API.IntradayURL + symbol + "&interval=" + "\(interval)min" + "&outputsize=" + outputSize + "&apikey=" + Constants.API.APIKEY) else { return print("error fetching api")}
        
        print("Fetching API: \(url)")
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching fetchIntraday: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }
            
            if let data = data,
                let intradayData = try? JSONDecoder().decode(APIData.self, from: data) {
                completionHandler(intradayData)
            }
        })
        task.resume()
    }
    
    func fetchDailyAdjusted(symbol: String, completionHandler: @escaping (APIData) -> Void) {
           guard let url = URL(string: Constants.API.BaseURL + Constants.API.DailyAdjusted + symbol + "&outputsize=compact" + "&apikey=" + Constants.API.APIKEY) else { return print("error fetching api")}
           
           print("Fetching API: \(url)")
           
           let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
               if let error = error {
                   print("Error with fetching fetchIntraday: \(error)")
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
                       print("Error with the response, unexpected status code: \(String(describing: response))")
                       return
               }
               
               if let data = data,
                   let intradayData = try? JSONDecoder().decode(APIData.self, from: data) {
                   completionHandler(intradayData)
               }
           })
           task.resume()
       }
    
    func fetchSearchResult(keyword: String, completionHandler: @escaping (SearchResult) -> Void) {
        guard let url = URL(string: Constants.API.BaseURL + Constants.API.SearchURL + keyword + "&apikey=" + Constants.API.APIKEY) else { return print("error fetching API") }
           
           let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
               if let error = error {
                   print("Error with fetching fetchSearchResult: \(error)")
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) else {
                       print("Error with the response, unexpected status code: \(String(describing: response))")
                       return
               }
               
               if let data = data,
                let searchData = try? JSONDecoder().decode(SearchResult.self, from: data) {
                completionHandler(searchData)
               }
           })
           task.resume()
       }
    
}


