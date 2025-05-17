//
//  FixtureCollectionViewCell.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

import UIKit
import SDWebImage

class FixtureCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamOneName: UILabel!
    @IBOutlet weak var teamOne: UIImageView!
    @IBOutlet weak var teamTwo: UIImageView!
    @IBOutlet weak var teamTwoName: UILabel!
    @IBOutlet weak var finalScore: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    
    }
    func configureCell(fixture: FixtureModel,sportName : String?){
       if sportName == "tennis" {
               teamOne.sd_setImage(with: URL(string: fixture.event_first_player_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamOneName.text = fixture.event_first_player
               teamTwo.sd_setImage(with: URL(string: fixture.event_second_player_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamTwoName.text = fixture.event_second_player
           } else {
               teamOne.sd_setImage(with: URL(string: fixture.home_team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamOneName.text = fixture.event_home_team
               teamTwo.sd_setImage(with: URL(string: fixture.away_team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamTwoName.text = fixture.event_away_team
           }

           // Handle final score display
           if sportName == "cricket" {
               finalScore.text = fixture.event_home_final_result == "-" ? " " : fixture.event_home_final_result
           } else {
               finalScore.text = fixture.event_final_result == "-" ? " " : fixture.event_final_result
           }
    }

}
