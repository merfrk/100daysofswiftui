//
//  PhotoItem.swift
//  PhotoLabel
//
//  Created by Omer on 2.09.2025.
//
import SwiftData
import Foundation

@Model
class PhotoItem {
    var id: UUID
    var name: String
    var fileName: String
    
    init(name: String, fileName: String) {
        self.id = UUID()
        self.name = name
        self.fileName = fileName
    }
}
