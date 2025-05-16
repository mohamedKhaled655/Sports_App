//
//  UrlBuilder.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//
import Foundation

class UrlSportBuilder {
    let BASE_URL:String = "https://apiv2.allsportsapi.com/"
    let API_KEY = "0a986c69d14837fcda0d3c098123b0acd7c7ff340baa1ff5aa50bd828473f990"
    private var url:String = ""
    
    init(sportType:String,methodType:MethodType){
        appendBaseURL()
        appendSportType(sportType:sportType)
        appendAPIKey()
        appendMethodType(methodType: methodType)
    }
    
    //MAKS:- add the baseurl
    private func appendBaseURL(){
        url.append(BASE_URL)
    }
    //MAKS:- add the sport type
    private func appendSportType(sportType:String){
        url.append(sportType)
    }
    //MAKS:- add the ApiKey
    private func appendAPIKey(){
        url.append("?APIkey=\(API_KEY)")
    }
    
    //MAKS:- add the methode
    private func appendMethodType(methodType:MethodType){
        url.append("&met=\(methodType.rawValue)")
    }
    
    //MAKS:- add the date from to
    func appendDateFromTo()->UrlSportBuilder{
           let date = Date()
           let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US")
        
            let startTime = dateFormatter.string(from: date)
            var dateComponent = DateComponents()
            dateComponent.day = 14
            var LastTimeDate = Calendar.current.date(byAdding: dateComponent, to: date)

            
            let lastTime = dateFormatter.string(from: LastTimeDate!)
        
            url.append("&from=\(startTime)&to=\(lastTime)")
            return self
        }
    
    //MAKS:- add the league id when calling the fixture endpoint
    func appendLeagueID(id:Int)->UrlSportBuilder{
        
        url.append("&leagueId=\(id)")
        return self
    }
    //MAKS:- add the team id when calling the team end point
    func appendTeamID(id:Int)->UrlSportBuilder{
        
        url.append("&teamId=\(id)")
        return self
    }
    
    //MAKS:- get the url as string
    func toString()->String{
        return url
    }
    
    //MAKS:- get the url as URL
    func toURL()->URL!{
        return URL(string: url)!
    }
}
enum SportsType:String{
    case football = "football"
    case basketball = "basketball"
    case cricket = "cricket"
    case tennis = "tennis"
}


enum MethodType:String{
    case Leagues = "Leagues"
    case Fixtures = "Fixtures"
    case Standings = "Standings"
    case Teams = "Teams"
}
