//
//  DateUtils.swift
//
//  Created by Mikhail Belikov on 28.03.2024.
//

import Foundation

func getCurrentDateFormatted() -> String {
    let currentDate = Date()
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }()
    
    return dateFormatter.string(from: currentDate)
}
