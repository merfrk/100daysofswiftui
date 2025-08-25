//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Omer on 25.08.2025.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
    List{
         Section("Basic Info"){
                Text("Name: \(user.name)")
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
       }
    Section("About"){
    Text(user.about)
}
    
    Section("Registered") {
                Text(user.registered)
            }
            
            Section("Tags") {
                ForEach(user.tags, id: \.self) { tag in
                    Text(tag)
                }
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
       }
.navigationTitle((user.name))
    }
}

#Preview {
    let sampleFriend1 = Friend(id: UUID(), name: "Alice Johnson")
    let sampleFriend2 = Friend(id: UUID(), name: "Bob Smith")
    
    let sampleUser = User(
        id: UUID(),
        isActive: true,
        name: "John Doe",
        age: 30,
        company: "OpenAI",
        email: "john.doe@example.com",
        address: "123 Main Street",
        about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel sem id nulla tincidunt luctus.",
        registered: "2025-01-01T12:00:00Z",
        tags: ["developer", "swift", "ios"],
        friends: [sampleFriend1, sampleFriend2]
    )
    
    return NavigationStack {
        UserDetailView(user: sampleUser)
    }
}
