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
        }

        private func setupAnimation() {
            [football, basketball, cricket, tennis].forEach {
                $0?.contentMode = .scaleAspectFit
                $0?.loopMode = .playOnce
                $0?.animationSpeed = 0.75
                $0?.play()
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
                navigationController?.pushViewController(leaguesVC, animated: true)
            }
        }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return sports.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportCollectionViewCell
//        
//        cell.sportName.text = sports[indexPath.item].name
//        
//        
//        cell.sportImage.image = UIImage(named: sports[indexPath.item].image ?? "fifa")
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.frame.width - 30) / 2
//        return CGSize(width: width, height: width)
//    }
//    
//   
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedSport = sports[indexPath.row].name
//        print("Selected sport: \(selectedSport ?? "")")
//        if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as? LeagueViewController {
//            leaguesVC.selectedSportName = selectedSport
//            navigationController?.pushViewController(leaguesVC, animated: true)
//        }
//    }


}

