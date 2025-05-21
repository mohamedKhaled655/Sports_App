//
//  DetialsCollectionViewController.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetialsCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout , DetialsViewProtocol , FavouriteCellProtocol{
   
    

    var availableSections: [SectionType] = []
    var upcomingFixtures : [FixtureModel] = []
    var latestFixtures : [FixtureModel] = []
    var standingTeams : [TeamStanding] = []
    var league : LeagueModel?
    var presenter : DetialsPresenter?
    var sportName : String?
    var leaugeId : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.circle"),
            style: .plain,
            target: self,
            action: #selector(navigationBarButtonTapped)
        )
        rightBarButton.tintColor = UIColor(red: 1.0, green: 0.25, blue: 0.0, alpha: 1.0)
         navigationItem.rightBarButtonItem = rightBarButton
        collectionView.setCollectionViewLayout(layout, animated: true)
        updateFavButtonIcon()
    }
 
    //MARK: - draw Section
    func drawUpComingFixture() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(350), heightDimension: .absolute(200))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)

         let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(350), heightDimension: .absolute(200))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 25
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 8, bottom:12, trailing: 8)
        addHeader(to: section)
         return section
        
    }
    func drawlatestFixture() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(390), heightDimension: .absolute(150))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(390), heightDimension: .absolute(150))
          let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: (UIScreen.main.bounds.width - 390) / 2, bottom: 2, trailing: (UIScreen.main.bounds.width - 390) / 2)
        addHeader(to: section)
          return section
    }
    func drawTeam() -> NSCollectionLayoutSection {
         let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(180), heightDimension: .absolute(250))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)

         let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(180), heightDimension: .absolute(250))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .groupPagingCentered
         section.orthogonalScrollingBehavior = .continuous
         section.interGroupSpacing = 10
         section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 12, bottom:24, trailing: 24)
        addHeader(to: section)
         return section
        
    }
    func addHeader(to section: NSCollectionLayoutSection, height: CGFloat = 50) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(height))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        // 👇 Place the header *behind* the section items
        header.zIndex = -1
        section.contentInsets.top += height
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
            cell.applyFocusedStyle()
            return cell
        case .latest:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fCell", for: indexPath) as! FixtureCollectionViewCell
            cell.configureCell(fixture: latestFixtures[indexPath.item], sportName: self.sportName)
            cell.applyNormalStyle()
            return cell
        case .standings:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tCell", for: indexPath) as! LeaguesTeamCollectionViewCell
            cell.configureCell(standingteam: standingTeams[indexPath.item])
            cell.animatePop()
            cell.applyFocusedStyle()
            return cell
        }
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch availableSections[indexPath.section] {
        case .upcoming:
            if let fixtureCell = cell as? FixtureCollectionViewCell {
                fixtureCell.animatePop()
                fixtureCell.applyPopStyle()
                fixtureCell.animateZoomIn()
                fixtureCell.applyFocusedStyle()
            }
        case  .latest:
            if let fixtureCell = cell as? FixtureCollectionViewCell {
                fixtureCell.animatePop()
            }
        case .standings:
            if let teamCell = cell as? LeaguesTeamCollectionViewCell {
                teamCell.animatePop()
                teamCell.applyPopStyle()
                teamCell.animateZoomIn()
                teamCell.applyFocusedStyle()
                
            }
        }
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = scrollView as? UICollectionView else { return }
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 24
            layout.minimumInteritemSpacing = 20
            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        let visibleCells = collectionView.visibleCells
        let visibleCenterX = collectionView.bounds.midX + collectionView.contentOffset.x
        let visibleCenterY = collectionView.bounds.midY + collectionView.contentOffset.y
        
        var closestCell: UICollectionViewCell?
        var smallestDistance: CGFloat = .greatestFiniteMagnitude
        
        for cell in visibleCells {
            guard let indexPath = collectionView.indexPath(for: cell),
                  let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { continue }
            if availableSections[indexPath.section] == .latest {
                      (cell as? FixtureCollectionViewCell)?.applyNormalStyle()
                      continue
                  }
            let cellCenter = attributes.center
            let dx = cellCenter.x - visibleCenterX
            let dy = cellCenter.y - visibleCenterY
            let distance = sqrt(dx * dx + dy * dy)
            
            if distance < smallestDistance {
                smallestDistance = distance
                closestCell = cell
            }
        }
        
        for cell in visibleCells {
            guard let indexPath = collectionView.indexPath(for: cell) else { continue }
            if availableSections[indexPath.section] == .latest {
                       (cell as? FixtureCollectionViewCell)?.applyNormalStyle()
                       continue
                   }
            if cell == closestCell {
                (cell as? FixtureCollectionViewCell)?.applyFocusedStyle()
            } else {
                (cell as? FixtureCollectionViewCell)?.applyNormalStyle()
            }
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
               header.icon.image = UIImage(named: "fixtures")
           case .latest:
               header.header.text = "Latest Fixtures"
               header.icon.image = UIImage(named: "fixtures")
           case .standings:
               header.header.text = "Teams"
               header.icon.image = UIImage(named: "team")
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
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    //MARK: - handel add to favourite btn
    @objc func navigationBarButtonTapped() {
        guard let league = self.league else { return }
        
        if LocalDBManager.shared.isLeagueExist(leagueKey: league.league_key ?? 0) {
            // Remove from favorites
            LocalDBManager.shared.removeLeague(leagueKey: league.league_key ?? 0)
            // Update the button icon to unfilled heart
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.circle")
        } else {
            // Add to favorites
            addToFav(league)
            // Update the button icon to filled heart
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.circle.fill")
        }
    }
    func addToFav(_ league: LeagueModel) {
        let saveLeague = League(
               leagueKey: league.league_key,
               leagueName: league.league_name,
               sportName: sportName ?? "football",
               leagueLogo: league.league_logo ?? "\(sportName ?? " ")"
           )
           LocalDBManager.shared.insertLeague(saveLeague)
    }
    func updateFavButtonIcon() {
        guard let league = self.league else { return }
        let isFav = LocalDBManager.shared.isLeagueExist(leagueKey: league.league_key ?? 0)
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: isFav ? "heart.circle.fill" : "heart.circle")
    }

}
