//
//  LeaguesTeamCollectionViewCell.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

import UIKit
import SDWebImage
class LeaguesTeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    func configureCell(standingteam: TeamStanding?){
        teamImg.sd_setImage(with: URL(string: standingteam?.team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
        teamName.text = standingteam?.standing_team
    }

}
