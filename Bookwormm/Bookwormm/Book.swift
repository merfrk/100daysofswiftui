//
//  Book.swift
//  Bookwormm
//
//  Created by Omer on 22.08.2025.
//

import Foundation
import SwiftData


@Model class Book{
        var title: String
        var author: String
        var genre: String
        var review: String
        var rating: Int
        var date: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date = .now) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
}
