//
//  DetialsCollectionViewController.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetialsCollectionViewController: UICollectionViewController ,DetialsViewProtocol{
   
    
    var fixtures : [FixtureModel] = []
    var standingTeams : [TeamStanding] = []
    var presenter : DetialsPresenter?
    var sportName : String?
    var leaugeId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        presenter = DetialsPresenter(view: self)
        presenter?.fetchFixtures(sportName ?? "football",id: leaugeId ?? 0)
        presenter?.fetchStandingTeams(sportName ?? "football",id: leaugeId ?? 0)
        
    }

    //MARK: - DetialsProtocol Methodes
        func showFixture(_ fixture: [FixtureModel]) {
            self.fixtures = fixture
        }
        
        func showError(_ message: String) {
            print("Error: \(message)")
        }
        func showStanding(_ standingTeams: [TeamStanding]) {
            self.standingTeams = standingTeams
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}
