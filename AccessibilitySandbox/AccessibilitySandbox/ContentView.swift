//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Omer on 1.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 10
    
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    ContentView()
}
