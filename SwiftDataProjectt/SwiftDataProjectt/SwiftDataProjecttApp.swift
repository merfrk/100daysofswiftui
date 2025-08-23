//
//  SwiftDataProjecttApp.swift
//  SwiftDataProjectt
//
//  Created by Omer on 23.08.2025.
//
import SwiftData
import SwiftUI

@main
struct SwiftDataProjecttApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
