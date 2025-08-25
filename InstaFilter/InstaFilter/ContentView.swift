//
//  ContentView.swift
//  InstaFilter
//
//  Created by Omer on 25.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount = 0.0{
        didSet {
                print("New value is \(blurAmount)")
            }
    }
    var body: some View {
        VStack {
                    Text("Hello, World!")
                        .blur(radius: blurAmount)

                    Slider(value: $blurAmount, in: 0...20)

                    Button("Random Blur") {
                        blurAmount = Double.random(in: 0...20)
                    }
                }
    }
}

#Preview {
    ContentView()
}
