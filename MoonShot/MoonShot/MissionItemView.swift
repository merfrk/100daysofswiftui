//
//  MissionItemView.swift
//  MoonShot
//
//  Created by Omer on 26.06.2025.
//

import SwiftUI

struct MissionItemView: View {
    let mission: Mission
    let isGrid: Bool

    var body: some View {
        Group {
            if isGrid {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding()

                    VStack {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(.rect(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
            } else {
                HStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .clipShape(RoundedRectangle(cornerRadius: 6))

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(mission.formattedLaunchDate)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
}

#Preview("Grid & List") {
    let sampleMission = Mission(
        id: 1,
        launchDate: Date(),
        crew: [],
        description: "A test mission to preview layout.",
    )

    Group {
        MissionItemView(mission: sampleMission, isGrid: true)
            .padding()
            .background(.darkBackground)

        MissionItemView(mission: sampleMission, isGrid: false)
            .padding()
            .background(.darkBackground)
    }
}


