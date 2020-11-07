//
//  API.swift
//  dxc
//
//  Created by Juan on 07/11/2020.
//

import UIKit

class API {
    
    let BASE_URL = "https://soccer.sportmonks.com/api/v2.0/"
    let API_TOKEN = "YtLPJwnlpjCJRC9GFYcRr5KmBXbdqSDgUzYxzBSDjTgbjghtVjPkMkDrnfP9"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func getPlayersByName(name: String, completion: @escaping([Player]) -> Void) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: BASE_URL + "players/search/\(name)?api_token=\(API_TOKEN)") {

            guard let url = urlComponents.url else {
                return
            }
          
            print(url)
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in defer {
              self?.dataTask = nil
            }
            
            if let _ = error {
              //print(e.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let data = try JSONDecoder().decode(Data.self, from: data)
                    if(data.players.count > 0) {
                        completion(data.players)
                    }
                } catch {
                    print(error)
                }
            }
          }
            dataTask?.resume()
        }
    }
    
    

}
