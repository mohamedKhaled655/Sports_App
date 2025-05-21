//
//  FavouritesViewController.swift
//  Sports_App
//
//  Created by Macos on 19/05/2025.
//

import UIKit
import Reachability

class FavouritesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var favoritesTable: UITableView!
    //var favoriteLeagues: [League] = []
    var favoriteLeaguesByName: [String: [League]] = [:]
    var leagueName: [String] = []
    let reachability = try! Reachability()
    var isConnected: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        

        favoritesTable.delegate = self
        favoritesTable.dataSource = self
                
        let cellNib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        favoritesTable.register(cellNib, forCellReuseIdentifier: "LeagueCell")
        
        
        setupReachability()
        
    }
    
    func setupReachability() {
        reachability.whenReachable = {  _ in
            print("Network reachable")
            self.isConnected = true
        }
        
        reachability.whenUnreachable = {  _ in
            print("Network unreachable")
            self.isConnected = false
        }
        
        do {
            try reachability.startNotifier()
            isConnected = reachability.connection != .unavailable
        } catch {
            print("Unable to start notifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    deinit {
            reachability.stopNotifier()
        }
    func loadFavorites() {
        let favoriteLeagues = LocalDBManager.shared.getAllLeaguesFromDB()
        
        var tempDict: [String: [League]] = [:]
        for league in favoriteLeagues {
            let name = league.sportName ?? ""
            if tempDict[name] != nil{
                tempDict[name]?.append(league)
            }else{
                tempDict[name] = [league]
            }
            
        }
        
        favoriteLeaguesByName = tempDict
        leagueName = favoriteLeaguesByName.keys.sorted()
        
        print("Loaded favorites: \(favoriteLeagues.count)")
        self.favoritesTable.reloadData()
        
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return leagueName.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let name = leagueName[section]
        return favoriteLeaguesByName[name]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return leagueName[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let league = favoriteLeagues[indexPath.row]
        let name = leagueName[indexPath.section]
        let league = favoriteLeaguesByName[name]?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        
        cell.cellView.layer.cornerRadius = 16
        cell.leagueTitle.text = league?.leagueName
        cell.leagueImage.sd_setImage(with: URL(string: league?.leagueLogo ?? ""), placeholderImage: UIImage(named: "fifa"))
        cell.delegate = nil
        
        cell.favBtn.isHidden = true
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = leagueName[indexPath.section]
            let leagueKey = favoriteLeaguesByName[name]?[indexPath.row].leagueKey
            let alert = UIAlertController(
                    title: "Confirm Deletion",
                    message: "Are you sure you want to remove \"\(favoriteLeaguesByName[name]?[indexPath.row].leagueName ?? "")\" from favorites?",
                    preferredStyle: .alert
                )
                    
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                LocalDBManager.shared.removeLeague(leagueKey: leagueKey ?? 0)
                self.loadFavorites()
                    }))
                    
            self.present(alert, animated: true, completion: nil)
        
           
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if isConnected {
            let name = leagueName[indexPath.section]
            let selectedSport = favoriteLeaguesByName[name]?[indexPath.row].sportName
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DetialsCollectionViewController") as? DetialsCollectionViewController {
                vc.sportName = selectedSport
                vc.leaugeId = favoriteLeaguesByName[name]?[indexPath.row].leagueKey
                vc.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let alert = UIAlertController(
                title: "No Internet Connection",
                message: "Please check your internet connection and try again.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
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
