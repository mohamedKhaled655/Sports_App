//
//  LeagueTableViewCell.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var leagueTitle: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    
    var delegate: FavouriteCellProtocol?
    var leagueModel: LeagueModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addFavBtn(_ sender: Any) {
        print("Favorite button pressed")
        if let league = leagueModel {
            delegate?.addToFav(league)
        }
    }
}
