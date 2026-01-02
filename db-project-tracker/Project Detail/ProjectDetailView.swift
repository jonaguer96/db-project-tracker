//
//  ProjectDetailView.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 10/12/25.
//

import SwiftUI

struct ProjectDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    var project: Project
    
    @State private var newUpdate: ProjectUpdate?
    @State private var showEditFocus = false
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [Color("Navy"), Color("Washed Blue")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(colors: [Color("Blue").opacity(0), Color("Teal")], startPoint: .top, endPoint: .bottom)
                .frame(width: 1)
                .padding(.leading, -150)
            
            VStack {
                // Header
                VStack (alignment: .leading, spacing: 13){
                    Text(project.name)
                        .font(.screenHeading)
                    
                    
                    HStack (alignment: .center, spacing: 13) {
                        Spacer()
                        StatBubbleView(title: "Hours", stat: "290", startColor: Color("Navy"), endColor: Color("Blue"))
                        StatBubbleView(title: "Sessions", stat: "34", startColor: Color("Green"), endColor: Color("Lime"))
                        StatBubbleView(title: "Updates", stat: "32", startColor: Color("Maroon"), endColor: Color("Purple"))
                        StatBubbleView(title: "Wins", stat: "9", startColor: Color("Maroon"), endColor: Color("Olive"))
                        Spacer()
                    }
                    
                    Text("My current focus is...")
                        .font(.featuredText)
                    HStack {
                        if (project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                            
                            Button {
                                //Complete milestone
                                completeMilestone()
                            } label: {
                                Image(systemName: "checkmark.square")
                            }
                        }
                        Text(project.focus.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "Tap to set your focus" : project.focus)
                            .font(.featuredText)
                            .onTapGesture {
                                // Display the edit focus form
                                showEditFocus = true
                            }
                    }
                    .padding(.leading)
                }
                .foregroundStyle(.white)
                .padding()
                .background {
                    Color.black
                        .opacity(0.7)
                        .clipShape(.rect(bottomLeadingRadius: 15, bottomTrailingRadius: 15))
                        .ignoresSafeArea()
                }
                // Project Updates
                ScrollView (showsIndicators: false) {
                    VStack (spacing: 27) {
                        ForEach(project.updates.sorted(by: { u1, u2 in
                            u1.date > u2.date 
                        })) { update in
                            ProjectUpdateView(update: update)
                                .onLongPressGesture {
                                    newUpdate = update
                                }
                        }

                    }
                    .padding()
                    .padding(.bottom, 80)
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        //Add project update
                        newUpdate = ProjectUpdate()
                    }, label: {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black)
                                .frame(width: 65)
                            Image("Cross")
                        }
                    })
                    .padding([.leading, .top])
                    Spacer()
                    Button("Back") {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.white)
                    .tint(.black)
                    .padding([.trailing, .top])
                }
                .background {
                    Color(.black)
                        .opacity(0.5)
                        .clipShape(.rect(topLeadingRadius: 15, topTrailingRadius: 15))
                        .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(item: $newUpdate) { update in
            
            let isEdit = update.headline.trimmingCharacters(in: .whitespacesAndNewlines) != ""
            
            EditUpdateView(project: project, update: update, isEditMode: isEdit )
                .presentationDetents([.fraction(0.3)])
                .background(Color.black) 
        }
        .sheet(isPresented: $showEditFocus) {
            EditFocusView(project: project)
                .presentationDetents([.fraction(0.2)])
                .background(Color.black)
        }
        
    }
    
    func completeMilestone() {
        //Create a new project update for milestone
        let update = ProjectUpdate()
        update.updateType = .milestone
        update.headline = "Milestone Achieved"
        update.summary = project.focus
        project.updates.insert(update, at: 0)
        // Clear the project focus
        project.focus = ""
    }
}
