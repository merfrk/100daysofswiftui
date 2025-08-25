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
                NavigationLink(destination: UserDetailView(user: user)){
                    HStack{
                        Text(user.name)
                        Spacer()
                        Circle()
                            .fill(user.isActive ? Color.green : Color.red)
                            .frame(width: 12, height: 12)
                    }
                }
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
