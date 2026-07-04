//
//  StatHelper.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 7/4/26.
//

import Foundation
import SwiftUI

struct StatHelper {
    
    // This method should be run AFTER the new update has been added to project's updates array
    static func updateAdded(project: Project, update: ProjectUpdate) {
        // Change hours
        project.hours += update.hours
        // Change wins
        if update.updateType == .milestone {
            project.wins += 1
        }
        // Change sessions
        let sortedUpdates = project.updates.sorted { u1, u2 in
            u1.date > u2.date
        }
        if sortedUpdates.count >= 2 {
            // Check if the latest two updates have the same date
            let date1 = sortedUpdates[0].date
            let date2 = sortedUpdates[1].date
            if !Calendar.current.isDate(date1, inSameDayAs: date2) {
                //If not the same day, then that means latest update is first of today
                project.sessions += 1
            }
        }
        else {
            //Since there are less than 2 updates, then this is the first of today
            project.sessions += 1
        }
    }
    // Run this AFTER update has been removed from project updates array
    static func updateDeleted(project: Project, update: ProjectUpdate) {
        // Change hours
        project.hours -= update.hours
        // Change wins
        if update.updateType == .milestone {
            project.wins -= 1
        }
        // Change sessions
        let sameDayUpdates = project.updates.filter { u in
            Calendar.current.isDate(u.date, inSameDayAs: update.date)
        }
        // After removal, decrement only if there are no remaining updates that day
        if sameDayUpdates.count == 0 {
            project.sessions -= 1
        }
    }
    
    static func updateEdited(project: Project, hoursDifference: Double) {
        // Change hours
        project.hours += hoursDifference
    }
    
}

