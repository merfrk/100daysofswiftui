//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Omer on 29.06.2025.
//

import SwiftUI

struct CheckoutView: View {

    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("thank you", isPresented: $showingConfirmation){
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
                confirmationMessage = "Failed to encode order."
                showingConfirmation = true
                return
            }

            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"

            do {
                let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

                // Gelen veriyi yazdır (debug için)
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Server response:\n\(responseString)")
                }

                // DOĞRUDAN KENDİ ORDER’INI KULLAN
                confirmationMessage = "Your order for \(order.quantity)x \(Order.types[order.type].lowercased()) cupcakes is on its way!"
                showingConfirmation = true

            } catch {
                confirmationMessage = "Checkout failed: \(error.localizedDescription)"
                showingConfirmation = true
            }
        
    }
}

#Preview {
    CheckoutView(order: Order())
}
