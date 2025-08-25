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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UserDetailView(user: User(id: "alsdkoaskdoas", isActive: true, name: "ahmet", age: 25, company: "asdasd", email: "asdasd@asdasd.com", address: "address", about: "asdasdasdas", registered: "dasasd", tags: ["asdasd","adsdas"], friends: Friend(id: "asdasd", name: "asdasd"),Friend(id: "asasdasd", name: "asdasd")))
}

