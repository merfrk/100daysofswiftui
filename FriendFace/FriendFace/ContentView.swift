//
//  ContentView.swift
//  FriendFace
//
//  Created by Omer on 24.08.2025.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @StateObject private var vm = UserViewModel()
    var body: some View {
        NavigationStack{
            List(users){ user in
                NavigationLink(user.name, destination: UserDetailView(user: user))
            }
            .navigationTitle("Users")
            .task{
                if users.isEmpty{
                    await vm.fetchUsers(modelContext: modelContext)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
