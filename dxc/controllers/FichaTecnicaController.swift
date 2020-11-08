//
//  FichaTecnicaController.swift
//  dxc
//
//  Created by Juan on 08/11/2020.
//

import UIKit

class FichaTecnicaController: UIViewController {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var teamPicture: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var tvTeamDes: UILabel!
    var playerId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Player id: \(playerId!)")
        
        API().getPlayerById(id: playerId!) {
            player in
            
            

            DispatchQueue.main.async {
                self.name.text = "\(player.name), \(player.getAge())"
                self.fullName.text = player.fullName
                
                if let altura = player.height, !altura.isEmpty {
                    self.height.text = "Altura: \(altura)"
                }
                if let peso = player.height, !peso.isEmpty {
                    self.weight.text = "Peso: \(peso)"
                }
                if let nacionalidad = player.height, !nacionalidad.isEmpty {
                    self.nationality.text = nacionalidad
                }
                
                if let url = player.image, !url.isEmpty {
                    self.picture.kf.setImage(with: URL(string: url))
                }
                
                if let teamId = player.image, !teamId.isEmpty {
                    API().getTeamById(id: teamId) {
                        team in

                        DispatchQueue.main.async {
                            
                            if let urlTeam = team.picture, !urlTeam.isEmpty {
                                self.teamPicture.kf.setImage(with: URL(string: urlTeam))
                            }
                            if let nameTeam = team.name, !nameTeam.isEmpty {
                                self.teamName.text = nameTeam
                            } else {
                                self.tvTeamDes.isHidden = true
                            }
                        }
                    }

                }
                
            }

        }
        
    }
    
}
