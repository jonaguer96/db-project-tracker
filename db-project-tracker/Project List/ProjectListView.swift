//
//  ContentView.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 9/7/25.
//

import SwiftUI
import SwiftData

struct ProjectListView: View {
    
    @State private var newProject: Project?
    @Query private var projects: [Project]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color("Deep Purple"), Color("Blush Pink")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading){
                    Text("Projects")
                        .font(Font.screenHeading)
                        .foregroundStyle(Color.white)
                    
                    ScrollView (showsIndicators: false){
                        VStack(alignment: .leading, spacing: 26) {
                            
                            ForEach(projects) { p in
                                
                                NavigationLink {
                                    ProjectDetailView(project: p)
                                } label: {
                                    ProjectCardView(project: p)
                                        .onLongPressGesture {
                                            newProject = p 
                                        }
                                }
                                .buttonStyle(.plain)
        
                            }
                            
                        }
                    }
                    
                }
                .padding()
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            // Create new project
                            self.newProject = Project()
                        }, label: {
                            ZStack {
                                Circle()
                                    .frame(width: 65)
                                    .foregroundColor(.black)
                                Image("Cross")
                            }
                        })
                        Spacer()
                    }
                }
                .padding(.leading)
            }
        }
        .sheet(item: $newProject) { project in
            
            let isEdit = project.name.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            
            EditProjectView(project: project, isEditMode: isEdit)
                .presentationDetents([.fraction(0.2)])
                .background(Color.black) 
        }
    }
}

#Preview {
    ProjectListView()
}
