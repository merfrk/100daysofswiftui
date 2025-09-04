//
//  DetailView.swift
//  PhotoLabel
//
//  Created by Omer on 3.09.2025.
//
import MapKit
import SwiftUI

struct DetailView: View {
    let photoItem: PhotoItem
    @State private var cameraPosition: MapCameraPosition = .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 39.9255, longitude: 32.8663),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )
    
    var body: some View {
        VStack(spacing: 20){
            if let imageData = photoItem.imageData,
               let uiimage = UIImage(data: imageData)
            {
                Image(uiImage: uiimage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            if let lat = photoItem.latitude, let lon = photoItem.longitude {
                            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                            
                            Map(position: $cameraPosition) {
                                Marker("Konum", coordinate: coordinate)
                            }
                            .frame(height: 300)
                            .cornerRadius(10)
                            .onAppear {
                                cameraPosition = .region(
                                    MKCoordinateRegion(
                                        center: coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    )
                                )
                            }
                        } else {
                            Text("Konum bilgisi yok")
                                .foregroundColor(.gray)
                        }

                        Spacer()
        }
        .padding()
                .navigationTitle(photoItem.name)
                .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    DetailView(photoItem: PhotoItem(name: "", imageData: Data()))
//}
