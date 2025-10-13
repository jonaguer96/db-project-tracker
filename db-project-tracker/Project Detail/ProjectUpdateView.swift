//
//  ProjectUpdateView.swift
//  db-project-tracker
//
//  Created by Jonathan Guerrero on 10/12/25.
//

import SwiftUI

struct ProjectUpdateView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.black)
                .shadow(radius: 5, x: 0, y: 4)
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    Text("Thursday, September 12, 2025")
                        .padding(.leading)
                    Spacer()
                    Text("9 Hours")
                        .padding(.trailing)
                }
                .padding(.vertical, 5)
                .background {
                    Color("Orchid")
                }
                Text("Project headline")
                    .font(.smallHeadline)
                    .padding(.horizontal)
                Text("ProjectSummary")
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .foregroundStyle(.white)
            .font(.regularText)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    ProjectUpdateView()
}
