//
//  Prospect.swift
//  HotProspects
//
//  Created by Omer on 5.09.2025.
//

import Foundation
import SwiftData

@Model
class Prospect{
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var createdAt: Date
    
    init(name: String, emailAddress: String, isContacted: Bool = false) {
        
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.createdAt = Date.now
        
    }
    
    
}
