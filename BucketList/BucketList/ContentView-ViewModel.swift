//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Omer on 29.08.2025.
//
import CoreLocation
import Foundation
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        var selectedPlace: Location?
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        var isUnlocked = false
        
        struct AuthError: Identifiable {
            let id = UUID()
            let message: String
        }
        
         var authError: String?
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
            save()
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluationError in
                    
                    Task{ @MainActor in
                        if success {
                            self.isUnlocked = true
                        } else if let evaluationError = evaluationError {
                            self.authError = evaluationError.localizedDescription
                        } else {
                            self.authError = "Authentication failed."
                        }
                    }
                }
            } else if let error = error {
                authError = error.localizedDescription
            } else {
                authError = "Biometrics not available."
            }
        }
    }
    
}
