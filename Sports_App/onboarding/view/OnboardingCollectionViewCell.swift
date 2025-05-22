//
//  OnboardingCollectionViewCell.swift
//  Sports_App
//
//  Created by Macos on 22/05/2025.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var slideDescriptionLabel: UILabel!
    @IBOutlet weak var slideTilteLabel: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(_ slide: OnboardingSlide){
        slideImageView.image = UIImage(named: slide.image)
        slideTilteLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }

}
