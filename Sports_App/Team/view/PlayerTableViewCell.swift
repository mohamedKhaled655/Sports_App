//
//  PlayerTableViewCell.swift
//  Sports_App
//
//  Created by Macos on 20/05/2025.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var playerNum: UILabel!
    @IBOutlet weak var playerType: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        playerImage.layer.cornerRadius = playerImage.frame.size.width / 2
        playerImage.clipsToBounds = true
    }
    
}
