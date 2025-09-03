//
//  AddView.swift
//  PhotoLabel
//
//  Created by Omer on 3.09.2025.
//
import PhotosUI
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var name = ""
    @State private var imageData: Data?
    var body: some View {
        NavigationStack{
            VStack{
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                PhotosPicker(selection: $selectedItem, matching: .images){
                    Text("Choose an image")
                }
                .onChange(of: selectedItem) {
                    Task{
                        if let data = try? await selectedItem?.loadTransferable(type: Data.self){
                            self.imageData = data
                        }
                    }
                }
                TextField("Photo name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                Button("Save"){
                    if let imageData = imageData, !name.isEmpty{
                        let newItem = PhotoItem(name: name, imageData: imageData)
                        modelContext.insert(newItem)
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                                .disabled(name.isEmpty || imageData == nil)
            }
            .navigationTitle("Add new photo")
            .toolbar{
                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        dismiss()
                                    }
                                }
            }
        }
    }
}

//#Preview {
//    AddView()
//}
