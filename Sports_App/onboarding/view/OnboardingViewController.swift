//
//  OnboardingViewController.swift
//  Sports_App
//
//  Created by Macos on 22/05/2025.
//

import UIKit

class OnboardingViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var sildes: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == sildes.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            }else{
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.isPagingEnabled = true
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        sildes = [
            OnboardingSlide(title: "Welcome", description: "Discover new sports!", image: "onboarding1"),
            OnboardingSlide(title: "Personalized Feed", description: "Get real-time scores, stats, and highlights from your favorite teams and leagues", image: "onboarding2"),
            OnboardingSlide(title: "Live Sports Updates", description: "Get real-time scores, stats, and highlights from your favorite teams and leagues", image: "onboarding3"),
            
        ]
        
    }


 
    @IBAction func nextBtnClicked(_ sender: Any) {
        if currentPage == sildes.count - 1 {
            print("go to home")
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBar")
                self.view.window?.rootViewController = homeVC
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sildes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setUp(sildes[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
}
