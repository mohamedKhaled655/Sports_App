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
    var players:[Player] = []
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
        self.players = team.first?.players ?? []
       
        DispatchQueue.main.async {
            print("players : \(self.players )")
           self.playersTable.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        
        cell.viewCell.layer.cornerRadius = 16
        
        let player = players[indexPath.row]
        cell.playerName.text = player.player_name
        cell.playerType.text = player.player_type
        cell.playerNum.text = player.player_number
        
        cell.playerImage.sd_setImage(with: URL(string: player.player_image ?? ""), placeholderImage: UIImage(named: "fifa"))
        
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
