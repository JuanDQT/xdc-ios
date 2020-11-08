//
//  API.swift
//  dxc
//
//  Created by Juan on 07/11/2020.
//

import UIKit
import SwiftyJSON

class API {
    
    let BASE_URL = "https://soccer.sportmonks.com/api/v2.0/"
    let API_TOKEN = "YtLPJwnlpjCJRC9GFYcRr5KmBXbdqSDgUzYxzBSDjTgbjghtVjPkMkDrnfP9"
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    func getPlayersByName(name: String, completion: @escaping([Data]) -> Void) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: BASE_URL + "players/search/\(name)?api_token=\(API_TOKEN)") {

            guard let url = urlComponents.url else {
                return
            }
          
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in defer {
              self?.dataTask = nil
            }
            
            if let _ = error {
              //print(e.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                let outputStr  = String(data: data, encoding: String.Encoding.utf8) as! String
                
                do {
                    let json = try JSON(data: data)
                    let jsonData = json["data"]
                    //print(jsonData.rawString())
                    let players: [Data] = try JSONDecoder().decode([Data].self, from: (jsonData.rawString()?.data(using: .utf8))!)
                    if(players.count > 0) {
                        completion(players)
                    }

                } catch {
                    print(error.localizedDescription)
                }

            }
          }
            dataTask?.resume()
        }
    }
    
    func getPlayerById(id: Int, completion: @escaping(Data) -> Void) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: BASE_URL + "players/\(id)?api_token=\(API_TOKEN)") {

            guard let url = urlComponents.url else {
                return
            }
          
            print(url)
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in defer {
              self?.dataTask = nil
            }

            let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as! String
            print(outputStr)

            if let _ = error {
              //print(e.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let json = try JSON(data: data)
                    let jsonData = json["data"]
                    let player: Data = try JSONDecoder().decode(Data.self, from: (jsonData.rawString()?.data(using: .utf8))!)
                    print(player)
                    completion(player)
                } catch {
                    print(error.localizedDescription)
                }
            }
          }
            dataTask?.resume()
        }
    }
    
    func getTeamById(id: String, completion: @escaping(Team) -> Void) {
        dataTask?.cancel()
            
        if var urlComponents = URLComponents(string: BASE_URL + "teams/\(id)?api_token=\(API_TOKEN)") {

            guard let url = urlComponents.url else {
                return
            }
          
            print(url)
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in defer {
              self?.dataTask = nil
            }

            let outputStr = String(data: data!, encoding: String.Encoding.utf8) as! String
            print(outputStr)

            // TODO: verificar porque arroja error.
            if let _ = error {
              //print(e.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let json = try JSON(data: data)
                    let jsonData = json["data"]
                    let player: Team = try JSONDecoder().decode(Team.self, from: (jsonData.rawString()?.data(using: .utf8))!)
                    print(player)
                    completion(player)
                } catch {
                    print(error.localizedDescription)
                }
            }
          }
            dataTask?.resume()
        }
    }
    
    

}
