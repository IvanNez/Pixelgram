//
//  DateExt.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit

extension Date {
    func getDateDiference() -> String {
        let currentDateInterval = Int(Date().timeIntervalSinceReferenceDate)
        let dateDifferences = Double(currentDateInterval - Int(self.timeIntervalSinceReferenceDate))
        let dateDifferencesDate = Int(round(dateDifferences/86400))
        
        switch dateDifferencesDate {
        case 0:
            return "Сегодня"
        case 1:
            return "Вчера"
        case 2...4:
            return "\(dateDifferencesDate) дня назад"
        default:
            return "\(dateDifferencesDate) дней назад"
        }
    }
    
    func formattDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru")
        formatter.dateFormat = "dd LLLL yyyy"
        return formatter.string(from: self)
    }
    
}


