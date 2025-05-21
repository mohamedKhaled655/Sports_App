//
//  LeagueViewController.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import SDWebImage

class LeagueViewController: UIViewController,UITableViewDataSource, UITableViewDelegate , UISearchBarDelegate , LeaguesViewProtocol ,FavouriteCellProtocol{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var leaguesTable: UITableView!
    
    var selectedSportName: String?
    
    var leaguesPresenter:LeaguesPresenter?
    var leagues:[LeagueModel] = []
    var filteredLeagues: [LeagueModel] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedSportName ?? "Leagues"
        
        leaguesTable.dataSource = self
        leaguesTable.delegate = self
        searchBar.delegate = self
        let cellNib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        leaguesTable.register(cellNib, forCellReuseIdentifier: "LeagueCell")
        searchBar.placeholder = "Search leagues..."
        
        
        leaguesPresenter = LeaguesPresenter(view: self, networkManager: NetworkManager())
        let sportName = selectedSportName ?? "football" 
        leaguesPresenter?.fetchLeagues(sportName)

     
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        leaguesPresenter?.searchLeagues(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = true
        leaguesTable.reloadData()
    }
    
    func showLeagues(_ leagues: [LeagueModel]) {
        self.filteredLeagues = leagues
        self.isSearching = true 
        DispatchQueue.main.async {
            self.leaguesTable.reloadData()
        }
    }
    
    func showError(_ message: String) {
        print("Error: \(message)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearching ? filteredLeagues.count : leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        
        cell.cellView.layer.cornerRadius = 16
        
        let league = isSearching ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
        cell.leagueTitle.text = league.league_name
        
        cell.leagueImage.sd_setImage(with: URL(string: league.league_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
        
        cell.leagueModel = league
        cell.delegate = self
        
        if LocalDBManager.shared.isLeagueExist(leagueKey: league.league_key ?? 0) {
            cell.favBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            
           } else {
            
            cell.favBtn.setImage(UIImage(systemName: "heart.circle"), for: .normal)
            
               
           }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let detials = self.storyboard?.instantiateViewController(withIdentifier: "DetialsCollectionViewController") as! DetialsCollectionViewController
        let league = isSearching ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
        detials.league = league
        detials.leaugeId = league.league_key
        detials.sportName = self.selectedSportName
        navigationController?.pushViewController(detials, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117
    }
    
    func addToFav(_ league: LeagueModel) {
        let saveLeague = League(leagueKey: league.league_key, leagueName: league.league_name, sportName: selectedSportName ?? "football", leagueLogo: league.league_logo ?? "\(selectedSportName)")
        
        LocalDBManager.shared.insertLeague(saveLeague)
        
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
