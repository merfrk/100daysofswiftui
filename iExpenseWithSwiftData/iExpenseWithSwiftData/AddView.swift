//
//  AddView.swift
//  iExpenseWithSwiftData
//
//  Created by Omer on 24.08.2025.
//
import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.words)
                
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){ type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle(Text("Add Expense"))
            .toolbar{
                Button("Save") {
                    let newItem = ExpenseItem(name: name, type: type, amount: amount)
                    modelContext.insert(newItem)
                    dismiss()
                }
                .disabled(name.isEmpty || amount <= 0)
            }
        }
    }
}

#Preview {
    AddView()
}
