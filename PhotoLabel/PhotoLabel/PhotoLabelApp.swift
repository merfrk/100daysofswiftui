//
//  PhotoLabelApp.swift
//  PhotoLabel
//
//  Created by Omer on 1.09.2025.
//
import SwiftData
import SwiftUI

@main
struct PhotoLabelApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: PhotoItem.self)
        }
    }
}
