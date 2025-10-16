//
//  EditFocusView.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 10/15/25.
//

import SwiftUI

struct EditFocusView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    @State var focus: String = ""
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Edit Project Focus")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                HStack {
                    TextField("Focus", text: $focus)
                        .textFieldStyle(.roundedBorder)
                    Button("Save") {
                        // Save focus of the project
                        project.focus = focus 
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

