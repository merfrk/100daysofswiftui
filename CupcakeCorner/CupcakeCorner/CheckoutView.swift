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
                    ProgressView("Loading....")
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
            confirmationMessage = "Failed to encode your order. Please try again."
            showingConfirmation = true
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Bu satırı yorum satırı yaparak isteği bilinçli olarak bozabilirsin:
         request.httpMethod = "POST"

        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // Opsiyonel: HTTP response kontrolü
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                confirmationMessage = "Server error: \(httpResponse.statusCode). Please try again later."
                showingConfirmation = true
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("Server response:\n\(responseString)")
            }

            confirmationMessage = "Your order for \(order.quantity)x \(Order.types[order.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true

        } catch {
            print("Upload failed with error: \(error.localizedDescription)")

            // Daha açıklayıcı hata mesajı
            confirmationMessage = """
            Your order could not be placed.
            Please check your internet connection and try again.
            Error: \(error.localizedDescription)
            """
            showingConfirmation = true
        }
    }

}

#Preview {
    CheckoutView(order: Order())
}
