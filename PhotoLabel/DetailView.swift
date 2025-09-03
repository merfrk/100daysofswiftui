//
//  DetailView.swift
//  PhotoLabel
//
//  Created by Omer on 3.09.2025.
//

import SwiftUI

struct DetailView: View {
    let photoItem: PhotoItem
    
    var body: some View {
        if let imageData = photoItem.imageData,
           let uiimage = UIImage(data: imageData)
        {
            Image(uiImage: uiimage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

//#Preview {
//    DetailView(photoItem: PhotoItem(name: "", imageData: Data()))
//}
