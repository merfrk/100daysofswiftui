//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Omer on 7.07.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            
            List{
                
            }
        }
        .navigationTitle("ExpenseTracker")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink{
                    AddView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
