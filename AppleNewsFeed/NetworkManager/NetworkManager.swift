//
//  NetworkManager.swift
//  AppleNewsFeed
//
//  Created by jazeps.ivulis on 10/05/2023.
//

import Foundation

class NetworkManager {
    
    static let api = "https://newsapi.org/v2/everything?q=apple&from=2023-05-15&to=2023-05-15&sortBy=popularity&apiKey=096d6fe8a40a4bcf97ce622582700a30"
    
    static func fetchData(url: String, completion: @escaping (NewsItems) -> () ) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, err ) in
            
            guard err == nil else {
                print("err:::::", err!)
                return
            }
            
            //print("response:", response as Any)
            
            guard let data = data else { return }
            
            
            do {
                let jsonData = try JSONDecoder().decode(NewsItems.self, from: data)
                completion(jsonData)
            }catch{
                print("err:::::", error)
            }
            
        }.resume()
    }
}
