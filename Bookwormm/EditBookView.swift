//
//  EditBookView.swift
//  Bookwormm
//
//  Created by Omer on 23.08.2025.
//
import SwiftData
import SwiftUI

struct EditBookView: View {
    @Bindable var book: Book
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form{
            Section("Book Info"){
                TextField("title", text: $book.title)
                TextField("author", text: $book.author)
            }
            Section("Review"){
                TextField("Write a review", text: $book.review, axis: .vertical)
            }
            Section("Rating"){
                RatingView(rating: $book.rating)
            }
        }
        .navigationTitle("Edit Book")
        .toolbar{
            Button("Done"){
                dismiss()
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)

        let example = Book(
            title: "Preview Book",
            author: "Preview Author",
            genre: "Fantasy",
            review: "This is a preview of the review text.",
            rating: 3,
            date: .now
        )

        return NavigationStack {
            EditBookView(book: example)
        }
        .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

