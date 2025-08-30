//
//  ContentView.swift
//  BucketList
//
//  Created by Omer on 27.08.2025.
//
import LocalAuthentication
import MapKit
import SwiftUI

enum MapMode: String, CaseIterable, Identifiable {
    case standard
    case hybrid
    
    var id: String { rawValue }
    
    var style: MapStyle {
        switch self {
        case .standard: .standard
        case .hybrid: .hybrid
        }
    }
}

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var mapMode: MapMode = .standard
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    var body: some View {
        if viewModel.isUnlocked {
            VStack {
                Picker("Map Mode", selection: $mapMode) {
                    ForEach(MapMode.allCases) { mode in
                        Text(mode.rawValue.capitalized).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                
                MapReader{ proxy in
                    Map(initialPosition: startPosition){
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Button {
                                    viewModel.selectedPlace = location
                                } label: {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(Circle())
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .mapStyle(mapMode.style)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local){
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace){ place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
            }
        } else{
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
        
    }
    
}

#Preview {
    ContentView()
}
