//
//  UserViewModel.swift
//  FriendFace
//
//  Created by Omer on 25.08.2025.
//
import SwiftData
import SwiftUI

@MainActor
class UserViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchUsers(modelContext: ModelContext) async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else{
            errorMessage = "Not a Valid URL"
            return
        }
        
        isLoading = true
        
        defer { isLoading = false}
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            
            for user in decodedUsers {
                modelContext.insert(user)
            }
            try modelContext.save()
        } catch{
            print("Fetch/Save Error", error)
            errorMessage = error.localizedDescription
        }
    }
}
