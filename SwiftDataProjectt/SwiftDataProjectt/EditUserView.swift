//
//  EditUserView.swift
//  SwiftDataProjectt
//
//  Created by Omer on 23.08.2025.
//
import SwiftData
import SwiftUI

struct EditUserView: View {
    @Bindable var user: User
    var body: some View {
        Form{
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("JoinDate", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Ahmet", city: "Adana", joinDate: .now)
        return EditUserView(user: user)
            .modelContainer(container)
    } catch{
        return Text("Failed to create container : \(error.localizedDescription)")
    }
}
