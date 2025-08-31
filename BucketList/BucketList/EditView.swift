//
//  EditView.swift
//  BucketList
//
//  Created by Omer on 29.08.2025.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar{
                Button("Save"){
                    viewModel.save()
                    dismiss()
                }
            }
            .task{
                await viewModel.fetchNearbyPlaces()
            }
        }
    }

    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(wrappedValue: EditView.ViewModel(location: location, onSave: onSave))
        
    }
    
}

#Preview {
    EditView(location: .example){ _ in
        
    }
}
