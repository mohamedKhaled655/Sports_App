//
//  LocalDBManager.swift
//  Sports_App
//
//  Created by Macos on 16/05/2025.
//

import Foundation
import CoreData
import UIKit


class LocalDBManager {
    static let shared = LocalDBManager()
    private init (){}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func insertLeague(_ league: League){
        
        if isLeagueExist(leagueKey: league.leagueKey ?? 0) {
                print("League already exists in favorites")
                return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "LeagueEntity", in: context)
        let leagueEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        leagueEntity.setValue(league.sportName, forKey: "sportName")
        leagueEntity.setValue(league.leagueName, forKey: "leagueName")
        leagueEntity.setValue(league.leagueKey, forKey: "leagueKey")
        leagueEntity.setValue(league.leagueLogo, forKey: "leagueLogo")
        
        do {
            try context.save()
            print("Added to favorites successfully")
        } catch {
            print("Failed to save")
        }
    }
    
    func getAllLeaguesFromDB () -> [League]{
        var leagues: [League] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        
        do{
            let result = try context.fetch(fetchRequest)
            for leagueEntity in result {
                let sportName = leagueEntity.value(forKey: "sportName") as? String
                let leagueName = leagueEntity.value(forKey: "leagueName") as? String
                let leagueKey = leagueEntity.value(forKey: "leagueKey") as? Int
                let leagueLogo = leagueEntity.value(forKey: "leagueLogo") as? String
                
                let league = League(leagueKey: leagueKey, leagueName: leagueName, sportName: sportName, leagueLogo: leagueLogo)
                            
                leagues.append(league)

                
            }
        }catch {
            print("Failed to fetch leagues: \(error.localizedDescription)")
        }
        
        
        return leagues
    }
    
    func removeLeague( leagueKey: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LeagueEntity")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results as! [NSManagedObject] {
                context.delete(object)
            }
            try context.save()
            print("Deleted league with key: \(leagueKey)")
        } catch {
            print("Failed to delete league: \(error.localizedDescription)")
        }
    }
    
    func isLeagueExist(leagueKey: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueEntity")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to check league existence: \(error.localizedDescription)")
            return false
        }
    }

}
