//
//  ViewController.swift
//  dxc
//
//  Created by Juan on 07/11/2020.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var dataList: [Data]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        loading.isHidden = true
    }
    
    // MARK: Prepare to go next controller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GO_DETALL_CONTROLLER" {
            //NotificationCenter.default.removeObserver(self)

            let controller = segue.destination as! FichaTecnicaController
            controller.playerId = sender as? Int
        }
    }
}

// MARK: - Extensions, Delegates
extension ViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CELL_ID", for: indexPath) as! MyCellController

    if let items = dataList {
        cell.name.text = items[indexPath.row].name
        cell.age.text = items[indexPath.row].getAge()
        if let img = items[indexPath.row].image {
            cell.picture.kf.setImage(with: URL(string: img))
        }
    }
    return cell

  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let data = dataList else { return 0 }

    return dataList!.count
    }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    if let items = dataList {
        performSegue(withIdentifier: "GO_DETALL_CONTROLLER", sender: items[indexPath.row].id)
    }
  }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.loading.isHidden = false

        API().getPlayersByName(name: searchText) {
            players in

            DispatchQueue.main.async {
                self.dataList = players
                self.tableView.reloadData()
                self.loading.isHidden = true
            }
        }
    }
}
