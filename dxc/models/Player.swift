//
//  Player.swift
//  dxc
//
//  Created by Juan on 07/11/2020.
//
import Foundation

struct Data: Decodable {
    let players: [Player]
    
    enum CodingKeys: String, CodingKey {
            case players = "data"
        }
}

struct Player: Decodable {
    let id: Int
    var name: String?
    var fullName: String
    var birthdate: String?
    var image: String?
    var teamId: Int?
    
    var height: String?
    var weight: String?
    var nationality: String
    
    // Buscar por boradcast.. nombre equipo y lofo

    
    enum CodingKeys: String, CodingKey {
        case id = "player_id"
        case name = "common_name"
        case fullName = "fullname"
        case birthdate
        case image = "image_path"
        
        case teamId
        case height
        case weight
        case nationality
      }
    
    // TODO: calculate getbirthdate
    func getAge() -> String {
        guard let checkDate = birthdate?.toDate() else {
            return ""
        }
        let now = Date()
        //let birthday: Date? = birthdate?.toDate()
        let calendar = Calendar.current

        let ageComponents = calendar.dateComponents([.year], from: checkDate, to: now)
        return "\(ageComponents.year!)"
        
    }
}
