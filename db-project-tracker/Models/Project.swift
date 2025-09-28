//
//  Project.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 9/7/25.
//

import Foundation
import SwiftData

@Model
class Project: Identifiable {
    
    @Attribute(.unique) var id: String
    var name = ""
    var startDate = Date()
    var focus = ""
    @Relationship(deleteRule: .cascade, inverse: \ProjectUpdate.project)
    var update: [ProjectUpdate] = [ProjectUpdate]()
    
    init() {
        id = UUID().uuidString
    }
}
