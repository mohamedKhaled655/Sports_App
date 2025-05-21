//
//  TeamViewController.swift
//  Sports_App
//
//  Created by Macos on 19/05/2025.
//

import UIKit
import SDWebImage

class TeamViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate ,TeamViewProtocol{

    
    @IBOutlet weak var playersTable: UITableView!
    var teamId: Int?
    var sportName: String?
    var teamPresenter:TeamPresenter?
    var playersByType: [String: [Player]] = [:]
    var playerTypes: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("teamId \(teamId ?? 0)")
        print("sport \(sportName ?? "")")
        
        playersTable.dataSource = self
        playersTable.delegate = self
        let cellNib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        playersTable.register(cellNib, forCellReuseIdentifier: "PlayerCell")
        
        teamPresenter = TeamPresenter(view: self, networkManager: NetworkManager())
        let sportName = sportName ?? "football"
        let teamId = teamId ?? 0
        teamPresenter?.fetchTeamDetails(sportName,teamId)
    }
    func showLeagues(_ team: [Team]) {
        let players = team.first?.players ?? []
        
        var tempDict: [String: [Player]] = [:]
        
        for player in players {
            let type = player.player_type ?? ""
            if tempDict[type] != nil{
                tempDict[type]?.append(player)
            }else{
                tempDict[type] = [player]
            }
        }
        
        playersByType = tempDict
        let customOrder = ["Goalkeepers", "Defenders", "Midfielders", "Forwards"]
        playerTypes = customOrder.filter{playersByType.keys.contains($0) }
        
        DispatchQueue.main.async {
            print("players : \(self.playersByType )")
           self.playersTable.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return playerTypes.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = playerTypes[section]
        return playersByType[type]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return playerTypes[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = playerTypes[indexPath.section]
        let player = playersByType[type]?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        cell.viewCell.layer.cornerRadius = 16
        
        cell.playerName.text = player?.player_name
        cell.playerType.text = player?.player_type
        cell.playerNum.text = player?.player_number
        cell.playerImage.sd_setImage(with: URL(string: player?.player_image ?? ""), placeholderImage: UIImage(named: "person"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 129
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
