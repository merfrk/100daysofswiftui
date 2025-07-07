import SwiftUI
import SwiftData

enum SortOrder: String, CaseIterable, Identifiable {
    case byDate = "Date"
    case byName = "Name"
    case byAmount = "Amount"

    var id: String { rawValue }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder: SortOrder = .byDate

    @Query var allItems: [ExpenseItem]  // sabit, sıralama içeride yapılır

    var sortedItems: [ExpenseItem] {
        switch sortOrder {
        case .byDate:
            return allItems.sorted { $0.date > $1.date }
        case .byName:
            return allItems.sorted { $0.name < $1.name }
        case .byAmount:
            return allItems.sorted { $0.amount > $1.amount }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Sort by", selection: $sortOrder) {
                    ForEach(SortOrder.allCases) { order in
                        Text(order.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                List {
                    Section("Business") {
                        ForEach(businessItems) { item in
                            ExpenseRow(item: item)
                        }
                        .onDelete { deleteItems($0, from: businessItems) }
                    }

                    Section("Personal") {
                        ForEach(personalItems) { item in
                            ExpenseRow(item: item)
                        }
                        .onDelete { deleteItems($0, from: personalItems) }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    var businessItems: [ExpenseItem] {
        sortedItems.filter { $0.type == "Business" }
    }

    var personalItems: [ExpenseItem] {
        sortedItems.filter { $0.type == "Personal" }
    }

    func deleteItems(_ offsets: IndexSet, from list: [ExpenseItem]) {
        for offset in offsets {
            let item = list[offset]
            modelContext.delete(item)
        }
    }
}

#Preview{
    ContentView()
}
