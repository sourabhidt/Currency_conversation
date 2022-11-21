//
//  Constants.swift
//  Calculation
//
//  Created by Kripa on 20/11/22.
//

import Foundation

struct AppConstants {
    static let serverURL: String = "https://api.apilayer.com/fixer/"

    enum URL {
        static let CURRENCIES_LATEST: String = "latest?"
//        static let CURRENCIES_LATEST: String = "latest?base=USD&symbols=EUR,GBP"
    }
}

class Constants {
    
    public static let search_history = "history"
    public static let today = "today"
    public static let yesterday = "yesterday"
    public static let day_before_yesterday = "day_before_yesterday"
    public static let userDefauls = UserDefaults.standard
    public static let dateFormat = "dd.MM.yyyy"
    
    public static func todayDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date_Today = dateFormatter.string(from: date)
        return date_Today
    }
    public static func yesterdayDate() -> String {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date_yesterday = dateFormatter.string(from: yesterday)
        return date_yesterday
    }
    public static func dayBeforeDate() -> String {
        let dayBefore = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date_dayBefore = dateFormatter.string(from: dayBefore)
        return date_dayBefore
    }
    
}
