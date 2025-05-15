//
//  LeagueViewController.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import SDWebImage

class LeagueViewController: UIViewController,UITableViewDataSource, UITableViewDelegate , LeaguesViewProtocol{
    

    @IBOutlet weak var leaguesTable: UITableView!
    
    var selectedSportName: String?
    
    var leaguesPresenter:LeaguesPresenter?
    var leagues:[LeagueModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedSportName ?? "Leagues"
        
        leaguesTable.dataSource = self
        leaguesTable.delegate = self
        let cellNib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        leaguesTable.register(cellNib, forCellReuseIdentifier: "LeagueCell")
        
        
        leaguesPresenter = LeaguesPresenter(view: self, networkManager: NetworkManager())
        let sportName = selectedSportName ?? "football" 
        leaguesPresenter?.fetchLeagues(sportName)

     
    }
    
    func showLeagues(_ leagues: [LeagueModel]) {
        self.leagues = leagues
        print("country_name: \(leagues[0].country_name)")
        DispatchQueue.main.async {
           self.leaguesTable.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        
        let league = leagues[indexPath.row]
        cell.leagueTitle.text = league.league_name
        
        cell.leagueImage.sd_setImage(with: URL(string: league.league_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
