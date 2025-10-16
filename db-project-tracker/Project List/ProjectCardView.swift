//
//  ProjectCardView.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 10/5/25.
//

import SwiftUI

struct ProjectCardView: View {
    
    var project: Project
    
    var body: some View {
        ZStack (alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.7)
                .shadow(radius: 10, x:0, y:4)
            VStack (alignment: .leading, spacing: 10) {
                Text(project.name)
                    .font(.bigHeadline)
                    .foregroundStyle(.white)
                HStack (alignment: .center, spacing: 13) {
                    Spacer()
                    StatBubbleView(title: "Hours", stat: "290", startColor: Color("Navy"), endColor: Color("Blue"))
                    StatBubbleView(title: "Sessions", stat: "34", startColor: Color("Green"), endColor: Color("Lime"))
                    StatBubbleView(title: "Updates", stat: "32", startColor: Color("Maroon"), endColor: Color("Purple"))
                    StatBubbleView(title: "Wins", stat: "9", startColor: Color("Maroon"), endColor: Color("Olive"))
                    Spacer()
                }
                if (project.focus.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                    Text("My current focus is...")
                        .font(.featuredText)
                        .foregroundStyle(Color.gray)
                    Text(project.focus)
                        .font(.featuredText)
                        .foregroundStyle(Color.gray)
                        .bold()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProjectCardView(project: Project())
}
