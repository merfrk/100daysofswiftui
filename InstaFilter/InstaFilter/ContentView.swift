//
//  ContentView.swift
//  InstaFilter
//
//  Created by Omer on 25.08.2025.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    
    @State private var processedImage: Image?
    @State private var intensity = 0.5
    @State private var radius = 10.0
    @State private var scale = 1.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    var hasImage: Bool{
        processedImage != nil
    }

    let context = CIContext()
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                PhotosPicker(selection: $selectedItem){
                    if let processedImage{
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else{
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to Import a Photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                Spacer()
                VStack{
                    HStack{
                        Text("Intensity")
                        Slider(value: $intensity, in: 0...1)
                            .onChange(of: intensity, applyProcessing)
                            .disabled(!hasImage)
                            .opacity(hasImage ? 1 : 0.5)
                    }
                    
                    
                    HStack{
                        Text("Radius")
                        Slider(value: $radius, in: 0...200)
                            .onChange(of: radius, applyProcessing)
                            .disabled(!hasImage)
                            .opacity(hasImage ? 1 : 0.5)
                    }
                    
                    
                    HStack{
                        Text("Scale")
                        Slider(value: $scale, in: 0...500)
                            .onChange(of: scale, applyProcessing)
                            .disabled(!hasImage)
                            .opacity(hasImage ? 1 : 0.5)
                    }
                    
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change Filter", action: changeFilter)
                        .disabled(!hasImage)
                    Spacer()
                    
                    if let processedImage{
                        ShareLink(item: processedImage, preview: SharePreview("InstaFilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .confirmationDialog("Select a Filter", isPresented: $showingFilters){
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Twirl") { setFilter(CIFilter.twirlDistortion())}
                Button("Exposure") { setFilter(CIFilter.exposureAdjust())}
                Button("Black & White") { setFilter(CIFilter.photoEffectNoir())}
                Button("Cancel", role: .cancel) { }

            }
        }
    }
    func changeFilter(){
        showingFilters = true
    }
    func loadImage(){
        Task{
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return}
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(radius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(scale, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputEVKey) { currentFilter.setValue(intensity * 2 - 1, forKey: kCIInputEVKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let UiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: UiImage)
    }
    
    @MainActor
    func setFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
        filterCount += 1
        if filterCount >= 20{
            requestReview()
            filterCount = 0
        }
    }
}

#Preview {
    ContentView()
}
