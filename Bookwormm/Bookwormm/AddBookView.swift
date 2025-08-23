//
//  AddBookView.swift
//  Bookwormm
//
//  Created by Omer on 22.08.2025.
//
import SwiftData
import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    private var hasEverythingFilled: Bool{
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return false
        } else{
            return true
        }
    }
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Name of the Book", text: $title)
                    TextField("Author's Name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review"){
                    TextEditor(text: $review)
                        
                    RatingView(rating: $rating)
                }
                
                Section{
                    Button("Save"){
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
                .disabled(!hasEverythingFilled)
                .navigationTitle(Text("Add Book"))
            }
        }
    }
}

#Preview {
    AddBookView()
}
