//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Omer on 7.09.2025.
//
import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form{
            TextField("name", text: $prospect.name)
            TextField("email", text: $prospect.emailAddress)
        }
        .navigationTitle("Edit Prospect")
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button("Save"){
                    do { try modelContext.save() } catch { print(error) }
                                        dismiss()
                }
            }
        }
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "Ahlelel", emailAddress: "ahlelas@gmail.com", isContacted: true))
}
