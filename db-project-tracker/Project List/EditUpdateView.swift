//
//  AddUpdateView.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 10/13/25.
//

import SwiftUI

struct EditUpdateView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var project: Project
    var update: ProjectUpdate
    var isEditMode: Bool
    
    @State private var headline: String = ""
    @State private var summary: String = ""
    @State private var hours: String = ""
    @State private var showConfirmation: Bool = false
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(isEditMode ? "New Update":"New Update")
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                
                    TextField("Headline", text: $headline)
                        .textFieldStyle(.roundedBorder)
                TextField("Summary", text: $summary, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                HStack {
                    
                    TextField("Hours", text: $hours)
                        .keyboardType(.numberPad)
                        .frame(width: 100)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(isEditMode ? "Save" : "Add") {
                        
                        //Either case we want to update the hupdates, headlines and summaries.
                        update.headline = headline
                        update.summary = summary
                        update.hours = Double(hours)!
                        
                        if !isEditMode {
                            // Add Project Update
                            // If it is NOT in EditMode, we need to insert that update.
                            project.updates.insert(update, at: 0)
                        }
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                    if isEditMode {
                        Button("Delete") {
                            //Show Confirmation Dialog
                            showConfirmation = true
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
            }
            Spacer()
        }
        .confirmationDialog("Really Delete?", isPresented: $showConfirmation, titleVisibility: .visible)  {
            Button("Yes, delete it") {
                // Remove all updates from the project with the same id
                project.updates.removeAll { u in
                    u.id == update.id
                }
                dismiss()
            }
        }
        .onAppear {
            headline = update.headline
            summary = update.summary
            hours = String(Int(update.hours))
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
