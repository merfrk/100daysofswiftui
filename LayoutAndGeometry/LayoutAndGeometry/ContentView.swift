//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Omer on 10.09.2025.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .named("scroll")).minY
                        let centerY = fullView.size.height / 2
                        let rotation = (minY - centerY) / 5
                        
                        // Fade calculation
                        let fadeStart: CGFloat = 0       // top edge
                        let fadeDistance: CGFloat = 200  // 200pt fade-out zone
                        let progress = max(0, min(1, (minY - fadeStart) / fadeDistance))
                        let opacity = progress  // 1 → 0 as it gets closer to top
                        
                        // Scale adjustment: 0.5 → 1.0 based on vertical position
                        let scaleMin: CGFloat = 0.5
                        let scaleRange: CGFloat = 0.5
                        let scaleProgress = max(0, min(1, minY / centerY))
                        let scale = scaleMin + (scaleRange * scaleProgress)
                        
                        // Dynamic hue (wraps around the rainbow)
                                                    let hue = (minY / fullView.size.height).truncatingRemainder(dividingBy: 1)
                                                    let dynamicColor = Color(hue: hue, saturation: 0.8, brightness: 0.9)
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(dynamicColor)
                            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity)
                            .scaleEffect(scale, anchor: .center)
                    }
                    .frame(height: 40)
                }
            }
        }
        .coordinateSpace(name: "scroll")
    }
}

#Preview {
    ContentView()
}
