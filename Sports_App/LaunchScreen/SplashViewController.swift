//
//  SplashViewController.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 20/05/2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    

    @IBOutlet weak var animationview: LottieAnimationView!
    let isFirstLaunch = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.animateDisplay()
        
    }
    private func animateDisplay() {
        
         // 1. Set animation content mode
         
        animationview.contentMode = .scaleAspectFit
        animationview.loopMode = .playOnce
        animationview.animationSpeed = 0.75
        animationview.play { [weak self] finished in
            if finished {
                self?.navigateToHome()
            }
        }
            
        }
    private func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if isFirstLaunch {
            let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            self.view.window?.rootViewController = onboardingVC
        }else{
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeTabBar")
            self.view.window?.rootViewController = homeVC
        }
        
            
    }

}
