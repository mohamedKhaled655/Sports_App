//
//  DateUtils.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//
import Foundation

struct DateUtils {
    
    static func getStartDateString() -> String {
        let date = Date()
        return formatDate(date)
    }

    static func getEndDateString(value: Int = 14) -> String {
        guard let date = Calendar.current.date(byAdding: .day, value: value, to: Date()) else {
            return ""
        }
        return formatDate(date)
    }

    private static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}
