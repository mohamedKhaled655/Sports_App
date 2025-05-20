//
//  DetialsCollectionViewController.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetialsCollectionViewController: UICollectionViewController ,DetialsViewProtocol{

    var availableSections: [SectionType] = []
    var upcomingFixtures : [FixtureModel] = []
    var latestFixtures : [FixtureModel] = []
    var standingTeams : [TeamStanding] = []
    var presenter : DetialsPresenter?
    var sportName : String?
    var leaugeId : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(UINib(nibName: "FixtureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fCell")
        collectionView.register(UINib(nibName: "LeaguesTeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tCell")
        collectionView.register(UINib(nibName: "SectionHeaderView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "SectionHeaderView")

        presenter = DetialsPresenter(view: self)
        presenter?.fetchFixtures(sportName ?? "football",id: leaugeId ?? 0)
        if sportName != "tennis"{
            presenter?.fetchStandingTeams(sportName ?? "football",id: leaugeId ?? 0)
        }
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            let sectionType = self.availableSections[sectionIndex]
            switch sectionType {
            case .upcoming:
                return self.drawUpComingFixture()
            case .latest:
                return self.drawlatestFixture()
            case .standings:
                return self.drawTeam()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    //MARK: - draw Section
    func drawUpComingFixture() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(400), heightDimension: .absolute(250))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)

         let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(400), heightDimension: .absolute(250))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .continuous
         section.interGroupSpacing = 10
         section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom:12, trailing: 12)
        addHeader(to: section)
         return section
        
    }
    func drawlatestFixture() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(390), heightDimension: .absolute(250))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(390), heightDimension: .absolute(300))
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

          let section = NSCollectionLayoutSection(group: group)
          section.interGroupSpacing = 5
          section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
        addHeader(to: section)
          return section
    }
    func drawTeam() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(250))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)

         let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .absolute(250))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .continuous
         section.interGroupSpacing = 20
         section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 24, bottom:24, trailing: 24)
        addHeader(to: section)
         return section
        
    }
    func addHeader(to section: NSCollectionLayoutSection, height: CGFloat = 40) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(height))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
    }


    //MARK: - DetialsProtocol Methodes
     
    func showError(_ message: String) {
        print("Error: \(message)")
    }
    func showStanding(_ standingTeams: [TeamStanding]) {
        self.standingTeams = standingTeams
        print("standingTeams \(standingTeams)")
        updateAvailableSections()
        DispatchQueue.main.async {
            self.updateBackgroundView()
            self.collectionView.reloadData()
        }
    }
    
    func showUpcoming(_ fixtures: [FixtureModel]) {
        self.upcomingFixtures = fixtures
        updateAvailableSections()
        print("Upcoming fixture fetched from the view Controller: \(self.upcomingFixtures.count)")
        DispatchQueue.main.async {
            self.updateBackgroundView()
            self.collectionView.reloadData()
        }
    }
    
    func showLatest(_ fixtures: [FixtureModel]) {
        self.latestFixtures = fixtures
        updateAvailableSections()
        print("Latest fixture fetched from the view Controller: \(self.latestFixtures.count)")
        DispatchQueue.main.async {
            self.updateBackgroundView()
            self.collectionView.reloadData()
        }
    }

    func updateAvailableSections() {
        availableSections = []
        if !upcomingFixtures.isEmpty { availableSections.append(.upcoming) }
        if !latestFixtures.isEmpty { availableSections.append(.latest) }
        if !standingTeams.isEmpty { availableSections.append(.standings) }
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
        return availableSections.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch availableSections[section] {
         case .upcoming:
             return upcomingFixtures.count
         case .latest:
             return latestFixtures.count
         case .standings:
             return standingTeams.count
         }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch availableSections[indexPath.section] {
        case .upcoming:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fCell", for: indexPath) as! FixtureCollectionViewCell
            cell.configureCell(fixture: upcomingFixtures[indexPath.item], sportName: self.sportName)
            return cell
        case .latest:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fCell", for: indexPath) as! FixtureCollectionViewCell
            cell.configureCell(fixture: latestFixtures[indexPath.item], sportName: self.sportName)
            return cell
        case .standings:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! LeaguesTeamCollectionViewCell
            cell.configureCell(standingteam: standingTeams[indexPath.item])
            return cell
        }
    }

    //MARK: - UIImage Display if there is no Data
    func updateBackgroundView() {
        if upcomingFixtures.isEmpty && latestFixtures.isEmpty && standingTeams.isEmpty {
            let imageView = UIImageView(image: UIImage(named: "fifa"))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false

            let container = UIView()
            container.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 200),
                imageView.heightAnchor.constraint(equalToConstant: 200)
            ])

            collectionView.backgroundView = container
        } else {
            collectionView.backgroundView = nil
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
               return UICollectionReusableView()
           }

           let header = collectionView.dequeueReusableSupplementaryView(
               ofKind: kind,
               withReuseIdentifier: "SectionHeaderView",
               for: indexPath) as! SectionHeaderView

           // Assign title and style
           switch availableSections[indexPath.section] {
           case .upcoming:
               header.header.text = "Upcoming Fixtures"
           case .latest:
               header.header.text = "Latest Fixtures"
           case .standings:
               header.header.text = "Teams"
           }

           // Apply font and color styling (optional if not done in XIB)
           header.header.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

           return header
       }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = availableSections[indexPath.section]
        
        if section == .standings {
            let selectedTeam = standingTeams[indexPath.item]
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
            vc.teamId = selectedTeam.team_key
            vc.sportName = sportName
            navigationController?.pushViewController(vc, animated: true)
        }
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
