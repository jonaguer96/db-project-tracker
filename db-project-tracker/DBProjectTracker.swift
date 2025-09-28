//
//  db_project_trackerApp.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 9/7/25.
//

import SwiftUI
import SwiftData

@main
struct DBProjectTracker: App {
    var body: some Scene {
        WindowGroup {
            ProjectListView()
                .modelContainer(for: [Project.self, ProjectUpdate.self])
        }
    }
}
