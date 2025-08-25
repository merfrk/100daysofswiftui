//
//  User.swift
//  FriendFace
//
//  Created by Omer on 25.08.2025.
//
import Foundation
import SwiftData

@Model
class User: Identifiable, Decodable {
    @Attribute(.unique) var id: UUID
        var isActive: Bool
        var name: String
        var age: Int
        var company: String
        var email: String
        var address: String
        var about: String
        var registered: String
        var tags: [String]
        
        @Relationship(deleteRule: .cascade)
        var friends: [Friend]
        
        // normal init
        init(
            id: UUID,
            isActive: Bool,
            name: String,
            age: Int,
            company: String,
            email: String,
            address: String,
            about: String,
            registered: String,
            tags: [String],
            friends: [Friend]
        ) {
            self.id = id
            self.isActive = isActive
            self.name = name
            self.age = age
            self.company = company
            self.email = email
            self.address = address
            self.about = about
            self.registered = registered
            self.tags = tags
            self.friends = friends
        }
        
        // MARK: - Codable
        enum CodingKeys: CodingKey {
            case id, isActive, name, age, company, email, address, about, registered, tags, friends
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try container.decode(UUID.self, forKey: .id)
            self.isActive = try container.decode(Bool.self, forKey: .isActive)
            self.name = try container.decode(String.self, forKey: .name)
            self.age = try container.decode(Int.self, forKey: .age)
            self.company = try container.decode(String.self, forKey: .company)
            self.email = try container.decode(String.self, forKey: .email)
            self.address = try container.decode(String.self, forKey: .address)
            self.about = try container.decode(String.self, forKey: .about)
            self.registered = try container.decode(String.self, forKey: .registered)
            self.tags = try container.decode([String].self, forKey: .tags)
            self.friends = try container.decode([Friend].self, forKey: .friends)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(isActive, forKey: .isActive)
            try container.encode(name, forKey: .name)
            try container.encode(age, forKey: .age)
            try container.encode(company, forKey: .company)
            try container.encode(email, forKey: .email)
            try container.encode(address, forKey: .address)
            try container.encode(about, forKey: .about)
            try container.encode(registered, forKey: .registered)
            try container.encode(tags, forKey: .tags)
            try container.encode(friends, forKey: .friends)
        }
}
