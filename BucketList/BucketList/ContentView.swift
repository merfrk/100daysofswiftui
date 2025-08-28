//
//  ContentView.swift
//  BucketList
//
//  Created by Omer on 27.08.2025.
//
import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)

    }
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authanticationError in
                if success{
                    isUnlocked = true
                }else{
                    
                }
            }
        } else{
            // no biometrics
        }
    }
}

#Preview {
    ContentView()
}
