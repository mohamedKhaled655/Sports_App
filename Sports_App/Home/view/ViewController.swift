//
//  ViewController.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import SDWebImage

class ViewController: UIViewController ,UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
   
    

    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    let sports:[SportModel] = [
        SportModel(name: "football", image: "football"),
        SportModel(name: "basketball", image: "basketball"),
        SportModel(name: "cricket", image: "cricket"),
        SportModel(name: "tennis", image: "tennis"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportsCollectionView.delegate = self
        sportsCollectionView.dataSource = self
        
        let cellNib = UINib(nibName: "SportCollectionViewCell", bundle: nil)
        sportsCollectionView.register(cellNib, forCellWithReuseIdentifier: "SportsCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportCollectionViewCell
        
        cell.sportName.text = sports[indexPath.item].name
        
        
        cell.sportImage.image = UIImage(named: sports[indexPath.item].image ?? "fifa")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: width)
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSport = sports[indexPath.row].name
        print("Selected sport: \(selectedSport ?? "")")
        if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as? LeagueViewController {
            leaguesVC.selectedSportName = selectedSport
            navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }


}

