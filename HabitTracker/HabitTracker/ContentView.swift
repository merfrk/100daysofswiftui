import SwiftUI

struct ContentView: View {
    @StateObject var data = Activities()
    @State private var showingAddHabit = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(data.items) { activity in
                    NavigationLink(value: activity) {
                        VStack(alignment: .leading) {
                            Text(activity.title)
                                .font(.headline)
                            Text("Completed \(activity.completionCount) times")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("My Habits")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddActivityView(data: data)
            }
            .navigationDestination(for: Activity.self) { activity in
                if let index = data.items.firstIndex(of: activity) {
                    ActivityDetailView(activity: $data.items[index])
                }
            }
        }
    }
}
