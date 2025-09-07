//
//  AddView.swift
//  PhotoLabel
//
//  Created by Omer on 3.09.2025.
//
import SwiftUI
import PhotosUI
import MapKit
import CoreLocation

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var name = ""
    @State private var imageData: Data?
    
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9255, longitude: 32.8663), // varsayılan Ankara
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    private let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Fotoğraf önizleme
                    if let imageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    // Fotoğraf seçici
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Text("Choose an image")
                    }
                    .onChange(of: selectedItem) {
                        Task {
                            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                self.imageData = data
                            }
                        }
                    }
                    
                    // İsim
                    TextField("Photo name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    // Harita
                    Map(
                        coordinateRegion: $region,
                        interactionModes: .all,
                        annotationItems: selectedCoordinate.map { [IdentifiableCoordinate(coordinate: $0)] } ?? []
                    ) { item in
                        MapMarker(coordinate: item.coordinate, tint: .red)
                    }
                    .frame(height: 300)
                    .cornerRadius(10)
                    .gesture(
                        LongPressGesture(minimumDuration: 0.5)
                            .onEnded { _ in
                                // Haritanın ortasını seç
                                selectedCoordinate = region.center
                            }
                    )
                    
                    // Save butonu
                    Button("Save") {
                        if let imageData = imageData, !name.isEmpty {
                            let coord = selectedCoordinate ?? locationFetcher.lastKnownLocation
                            
                            let newItem = PhotoItem(name: name, imageData: imageData)
                            newItem.latitude = coord?.latitude
                            newItem.longitude = coord?.longitude
                            
                            DispatchQueue.main.async {
                                modelContext.insert(newItem)
                                try? modelContext.save()
                                dismiss()
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(name.isEmpty || imageData == nil || (selectedCoordinate == nil && locationFetcher.lastKnownLocation == nil))
                }
                .padding()
            }
            .navigationTitle("Add new photo")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                locationFetcher.start()
                if let coord = locationFetcher.lastKnownLocation {
                    region.center = coord
                    selectedCoordinate = coord
                }
            }
        }
    }
}


#Preview {
    AddView()
}
