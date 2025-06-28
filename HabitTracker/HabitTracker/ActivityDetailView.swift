import SwiftUI

struct ActivityDetailView: View {
    @Binding var activity: Activity

    var body: some View {
        VStack(spacing: 20) {
            Text(activity.description)
                .font(.body)
                .padding()

            Text("Completed \(activity.completionCount) times")
                .font(.title2)
                .bold()

            Button("Mark as Completed") {
                activity.completionCount += 1
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
