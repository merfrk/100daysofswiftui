import SwiftUI

struct MissionLinkView: View {
    let mission: Mission
    let isGrid: Bool

    var body: some View {
        NavigationLink(value: mission) {
            MissionItemView(mission: mission, isGrid: isGrid)
        }
    }
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingGrid = true

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    // Grid View
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                MissionLinkView(mission: mission, isGrid: true)
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                } else {
                    // List View
                    List(missions) { mission in
                        MissionLinkView(mission: mission, isGrid: false)
                            .listRowBackground(Color.darkBackground)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Image(systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                    }
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)

            // Navigation destination
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
    }
}

#Preview {
    ContentView()
}
