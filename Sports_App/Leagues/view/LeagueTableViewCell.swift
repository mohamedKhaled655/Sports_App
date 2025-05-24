//
//  LeagueTableViewCell.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var leagueTitle: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    
    var delegate: FavouriteCellProtocol?
    var leagueModel: LeagueModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        leagueImage.layer.cornerRadius = leagueImage.frame.size.width / 2
//        leagueImage.clipsToBounds = true
    }
    
    @IBAction func addFavBtn(_ sender: Any) {
        print("Favorite button pressed")
        guard let league = leagueModel else { return }
            
            if LocalDBManager.shared.isLeagueExist(leagueKey: league.league_key ?? 0) {
                LocalDBManager.shared.removeLeague(leagueKey: league.league_key ?? 0)
                favBtn.setImage(UIImage(systemName: "heart.circle"), for: .normal)
                
            } else {
                favBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
               
                delegate?.addToFav(league)
               
            }
    }
}
