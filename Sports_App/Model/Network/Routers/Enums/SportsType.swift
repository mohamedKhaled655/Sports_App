//
//  SportsType.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

enum SportsType:String{
    case football = "football"
    case basketball = "basketball"
    case cricket = "cricket"
    case tennis = "tennis"
    
    init?(rawValue: String) {
        switch rawValue {
        case "football":
            self = .football
        case "basketball":
            self = .basketball
        case "cricket":
            self = .cricket
        case "tennis":
            self = .tennis
        default:
            return nil
        }
    }
}
