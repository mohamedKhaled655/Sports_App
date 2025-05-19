//
//  FavouritesViewController.swift
//  Sports_App
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class FavouritesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var favoritesTable: UITableView!
    var favoriteLeagues: [League] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        

        favoritesTable.delegate = self
        favoritesTable.dataSource = self
                
        let cellNib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        favoritesTable.register(cellNib, forCellReuseIdentifier: "LeagueCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    func loadFavorites() {
        favoriteLeagues = LocalDBManager.shared.getAllLeaguesFromDB()
        print("Loaded favorites: \(favoriteLeagues.count)")
        self.favoritesTable.reloadData()
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLeagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = favoriteLeagues[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as! LeagueTableViewCell
        
        cell.leagueTitle.text = league.leagueName
        cell.leagueImage.sd_setImage(with: URL(string: league.leagueLogo ?? ""), placeholderImage: UIImage(named: "fifa"))
        cell.delegate = nil
        
        cell.favBtn.isHidden = true
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let leagueKey = favoriteLeagues[indexPath.row].leagueKey
            let alert = UIAlertController(
                    title: "Confirm Deletion",
                    message: "Are you sure you want to remove \"\(favoriteLeagues[indexPath.row].leagueName ?? "")\" from favorites?",
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
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
