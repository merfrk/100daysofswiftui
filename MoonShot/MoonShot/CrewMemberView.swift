//
//  CrewMemberView.swift
//  MoonShot
//
//  Created by Omer on 25.06.2025.
//

import SwiftUI

struct CrewMemberView: View {
    let crewMember: MissionView.CrewMember

    var body: some View {
        NavigationLink {
            AstronautView(astronaut: crewMember.astronaut)
        } label: {
            HStack(spacing: 10) {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .strokeBorder(.white, lineWidth: 1)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text(crewMember.astronaut.name)
                        .foregroundStyle(.white)
                        .font(.headline)

                    Text(crewMember.role)
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color(.lightBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

/*
#Preview {
    let sampleAstronaut = Astronaut(
            id: "armstrong",
            name: "Neil A. Armstrong",
            description: "First person to walk on the Moon."
        )

        let sampleCrewMember = CrewMember(
            role: "Commander",
            astronaut: sampleAstronaut
        )

    CrewMemberView(crewMember: sampleCrewMember)
            .preferredColorScheme(.dark)
            .background(.darkBackground)
            .previewLayout(.sizeThatFits)
            .padding()}

*/
