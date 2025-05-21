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
        teamOne.layer.cornerRadius = teamOne.frame.size.width / 2
        teamTwo.layer.cornerRadius = teamTwo.frame.size.width / 2
        teamOne.layer.masksToBounds = true
        teamTwo.layer.masksToBounds = true
          self.layer.borderColor = UIColor(red: 1.0, green: 0.25, blue: 0.0, alpha: 1.0).cgColor
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
           } else if sportName == "football"{
               teamOne.sd_setImage(with: URL(string: fixture.home_team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamOneName.text = fixture.event_home_team
               teamTwo.sd_setImage(with: URL(string: fixture.away_team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamTwoName.text = fixture.event_away_team
           }else {
               teamOne.sd_setImage(with: URL(string: fixture.event_home_team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamOneName.text = fixture.event_home_team
               teamTwo.sd_setImage(with: URL(string: fixture.event_away_team_logo ?? ""), placeholderImage: UIImage(named: "fifa"))
               teamTwoName.text = fixture.event_away_team
           }

           // Handle final score display
           if sportName == "cricket" {
               finalScore.text = fixture.event_home_final_result == "-" ? " " : fixture.event_home_final_result
           } else {
               finalScore.text = fixture.event_final_result == "-" ? " " : fixture.event_final_result
           }
    }
    func animatePop() {
        // Scale up slightly
        self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                           // Return to identity (original size)
                           self.transform = CGAffineTransform.identity
                       },
                       completion: nil)
    }
    func applyPopStyle() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 10
        self.layer.transform = CATransform3DMakeScale(1.02, 1.02, 1)
        let scale = CATransform3DMakeScale(1.07, 1.07, 1.0)
        let translation = CATransform3DMakeTranslation(0, -10, 0) // move upward a bit
        self.layer.transform = CATransform3DConcat(scale, translation)
    }
    func animateZoomIn() {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.6,
                       options: [.curveEaseOut],
                       animations: {
                           self.transform = .identity
                       }, completion: nil)
    }
    func applyFocusedStyle() {
            self.layer.cornerRadius = 24
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor(red: 1.0, green: 0.25, blue: 0.0, alpha: 1.0).cgColor
            self.layer.shadowOpacity = 0.4
            self.layer.shadowOffset = CGSize(width: 0, height: 20)
            self.layer.shadowRadius = 30

            // More aggressive scale and upward translation
            let scale = CATransform3DMakeScale(1.15, 1.15, 1.0)
            let translation = CATransform3DMakeTranslation(0, -25, 0)
            self.layer.transform = CATransform3DConcat(scale, translation)
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
                self.layer.transform = CATransform3DConcat(
                    CATransform3DMakeScale(1.15, 1.15, 1),
                    CATransform3DMakeTranslation(0, -25, 0)
                )
            }
    
    }

    func applyNormalStyle() {
        self.layer.shadowOpacity = 0
        self.layer.transform = CATransform3DIdentity
    }

}
