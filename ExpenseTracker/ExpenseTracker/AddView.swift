//
//  AddView.swift
//  ExpenseTracker
//
//  Created by Omer on 7.07.2025.
//
import SwiftData
import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    let types = ["Business","Personal"]
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
        }
        .navigationTitle("Add New Expense")
        .toolbar{
            Button("Save"){
                let newItem = ExpenseItem(name: name, type: type, amount: amount, date: .now)
                modelContext.insert(newItem)
                dismiss()
            }
            .disabled(name.isEmpty || amount <= 0)
        }
    }
}

#Preview {
    AddView()
}
