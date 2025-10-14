//
//  DateHelper.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 10/13/25.
//

import Foundation
struct DateHelper {
    static func projectUpdateDate(inputDate: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMMM d, yyyy"
        return df.string(from: inputDate)
    }
}
