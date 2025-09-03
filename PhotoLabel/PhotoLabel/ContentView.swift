//
//  ContentView.swift
//  PhotoLabel
//
//  Created by Omer on 1.09.2025.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \PhotoItem.name) var photos: [PhotoItem]
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(photos){ photo in
                    NavigationLink(destination: DetailView(photoItem: photo)){
                        HStack{
                            if let imageData = photo.imageData, let uiimage = UIImage(data: imageData) {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .scaledToFit( )
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            } else{
                                Text("No Photo")
                            }
                            VStack(alignment: .leading){
                                Text(photo.name)
                                    .font(.headline)
                            }
                        }
                    }
                }
                .onDelete(perform: deletePhotos)
            }
            .navigationTitle("Photo Collection")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddView = true
                    } label: {
                        Label("Add new photo", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView()
            }
            
        }
    }
    func deletePhotos(at offsets: IndexSet) {
        for offset in offsets {
            let photo = photos[offset]
            modelContext.delete(photo)
        }
    }
}

//#Preview {
//    ContentView()
//}
