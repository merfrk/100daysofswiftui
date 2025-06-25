import SwiftUI

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
                    // 🔳 Grid view
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    MissionItemView(mission: mission, isGrid: true)
                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                } else {
                    // 📋 List view
                    List(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            MissionItemView(mission: mission, isGrid: false)
                        }
                        .listRowBackground(Color.darkBackground)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Image(systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                    }
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
