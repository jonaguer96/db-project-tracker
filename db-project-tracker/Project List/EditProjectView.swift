//
//  AddProjectView.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 10/5/25.
//

import SwiftUI
import SwiftData

struct EditProjectView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    var isEditMode: Bool
    @State private var projectName: String = ""
    @State private var showConfirmation: Bool = false
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(isEditMode ? "Edit Project" : "Add Project")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                HStack {
                    TextField("Project name", text: $projectName )
                        .textFieldStyle(.roundedBorder)
                    Button(isEditMode ? "Save" : "Add") {
                        
                        if isEditMode {
                            //Save the new Project name
                            project.name = projectName
                            
                        }
                        else {
                            // Add project to SwiftData
                            project.name = projectName
                            context.insert(project)
                        }
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(projectName.trimmingCharacters(in: .whitespacesAndNewlines) == "")
                    
                    if isEditMode {
                     //Show Delete Button
                        Button("Delete") {
                            //Show confirmation dialogue
                            showConfirmation = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
            }
            Spacer()
        }
        .confirmationDialog("Really Delete?", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Yes, delete it") {
                // Delete project from SwiftData
                context.delete(project)
                dismiss()
            }
        }
        .onAppear {
            projectName = project.name
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
