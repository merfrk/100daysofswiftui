//
//  ContentView.swift
//  InstaFilter
//
//  Created by Omer on 25.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    var body: some View {
        Button("Hello, World!") {
                    showingConfirmation = true
                }
                .frame(width: 300, height: 300)
                .background(backgroundColor)
                .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                    Button("Red") { backgroundColor = .red }
                    Button("Green") { backgroundColor = .green }
                    Button("Blue") { backgroundColor = .blue }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("Select a new color")
                }
    }
}

#Preview {
    ContentView()
}
