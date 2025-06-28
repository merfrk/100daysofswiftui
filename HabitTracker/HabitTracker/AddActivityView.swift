import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var data: Activities

    @State private var title = ""
    @State private var description = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("New Activity")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let activity = Activity(title: title, description: description)
                        data.add(activity)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
