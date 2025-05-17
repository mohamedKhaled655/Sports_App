//
//  LeaguesTeamCollectionViewCell.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

import UIKit

class LeaguesTeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    var standingteam : TeamStanding?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        teamImg.sd_setImage(with: URL(string: standingteam?.team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
        teamName.text = standingteam?.standing_team
    }

}
