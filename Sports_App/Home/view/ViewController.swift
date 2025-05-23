//
//  ViewController.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import SDWebImage
import Lottie

class ViewController: UIViewController
//                      UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout
{
   
    @IBOutlet weak var football: LottieAnimationView!
    
    @IBOutlet weak var basketball: LottieAnimationView!
    
    @IBOutlet weak var cricket: LottieAnimationView!
    
    @IBOutlet weak var tennis: LottieAnimationView!
    
    let sports:[SportModel] = [
        SportModel(name: "football", image: "football"),
        SportModel(name: "basketball", image: "basketball"),
        SportModel(name: "cricket", image: "cricket"),
        SportModel(name: "tennis", image: "tennis"),
    ]
    override func viewDidLoad() {
            super.viewDidLoad()
            setupAnimation()
            setupTapGestures()
            styleAnimationViews()
        }

        private func setupAnimation() {
            [football, basketball, cricket, tennis].forEach {
                $0?.contentMode = .scaleAspectFit
                $0?.loopMode = .loop
                $0?.animationSpeed = 0.75
                $0?.play()
            }
        }
        private func styleAnimationViews() {
            let views = [football, basketball, cricket, tennis]
            views.forEach {
                $0?.layer.cornerRadius = 16
                $0?.layer.borderWidth = 2
                $0?.layer.borderColor = UIColor.orange.cgColor
                $0?.clipsToBounds = true
            }
        }

        private func setupTapGestures() {
            addTap(to: football, action: #selector(handleFootballTap))
            addTap(to: basketball, action: #selector(handleBasketballTap))
            addTap(to: cricket, action: #selector(handleCricketTap))
            addTap(to: tennis, action: #selector(handleTennisTap))
        }

        private func addTap(to view: UIView?, action: Selector) {
            view?.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: action)
            view?.addGestureRecognizer(tapGesture)
        }

        // MARK: - Tap Handlers

        @objc private func handleFootballTap() {
            navigateToScreen(withsSlectedSport: sports[0])
        }

        @objc private func handleBasketballTap() {
            navigateToScreen(withsSlectedSport: sports[1])
        }

        @objc private func handleCricketTap() {
            navigateToScreen(withsSlectedSport: sports[2])
        }

        @objc private func handleTennisTap() {
            navigateToScreen(withsSlectedSport: sports[3])
        }

        // MARK: - Navigation

        private func navigateToScreen(withsSlectedSport sportName: SportModel) {
            let selectedSport = sportName.name
            print("Selected sport: \(selectedSport ?? "")")
            if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as? LeagueViewController {
                leaguesVC.selectedSportName = selectedSport
                leaguesVC.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(leaguesVC, animated: true)
            }
        }


}

