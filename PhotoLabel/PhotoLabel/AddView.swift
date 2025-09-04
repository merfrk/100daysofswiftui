//
//  AddView.swift
//  PhotoLabel
//
//  Created by Omer on 3.09.2025.
//
import PhotosUI
import SwiftUI
import MapKit

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var name = ""
    @State private var imageData: Data?
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.9255, longitude: 32.8663), // Ankara default
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    private let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                PhotosPicker(selection: $selectedItem, matching: .images){
                    Text("Choose an image")
                }
                .onChange(of: selectedItem) {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                            self.imageData = data
                        }
                    }
                }
                TextField("Photo name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Map(position: $cameraPosition, interactionModes: .all) {
                    if let coord = selectedCoordinate {
                        Marker("Selected Location", coordinate: coord)
                    }
                }
                .frame(height: 300)
                .cornerRadius(10)
                .gesture(
                    TapGesture().onEnded { _ in
                        if let center = cameraPosition.region?.center {
                            selectedCoordinate = center
                        }
                    }
                )
                
                Button("Save"){
                    if let imageData = imageData, !name.isEmpty{
                        let coord = selectedCoordinate ?? locationFetcher.lastKnownLocation
                        let newItem = PhotoItem(name: name, imageData: imageData)
                        newItem.latitude = coord?.latitude
                        newItem.longitude = coord?.longitude
                        
                        do {
                            DispatchQueue.main.async{
                                modelContext.insert(newItem)
                                try? modelContext.save()
                            }
                        } catch {
                            print("Save failed: \(error.localizedDescription)")
                        }
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(name.isEmpty || imageData == nil)
            }
            .navigationTitle("Add new photo")
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddView()
}
