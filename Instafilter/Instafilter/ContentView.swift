//
//  ContentView.swift
//  Instafilter
//
//  Created by Mariana Montoya on 3/20/25.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

//struct ContentView: View {
//    @State private var image: Image?
//    
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadImage)
//    }
//    func loadImage() {
//        let inputImage = UIImage(resource: .example)
//        let beginImage = CIImage(image: inputImage)
//        
//        let context = CIContext()
//        let currentFilter = CIFilter.pixellate()
//        
//        currentFilter.inputImage = beginImage
//        let amount = 1.0
//        let inputKeys = currentFilter.inputKeys
//        
//        if inputKeys.contains(kCIInputScaleKey) {
//            currentFilter.setValue(amount, forKey: kCIInputScaleKey)
//        }
//        
//        currentFilter.scale = 50
//        
//        guard let outputImage = currentFilter.outputImage else { return }
//        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
//                else { return }
//        
//        let uiImage = UIImage(cgImage: cgImage)
//        image = Image(uiImage: uiImage)
//        
//        ContentUnavailableView{
//            Label("No snippets", systemImage: "swift")
//        } description: {
//            Text("You don't have any saved snippets yet.")
//        } actions: {
//            Button("Create snippet") {
//                
//            }
//            .buttonStyle(.borderedProminent)
//        }
//        
//        
//    }
//}

//struct ContentView: View {
//    @State private var pickerItems = [PhotosPickerItem]()
//    @State private var selectedImages = [Image]()
//    
//    var body: some View {
//        ShareLink(item: URL(string: "https://www.google.com")!, subject: Text("Look at my pixel!"), message: Text("Check it out!"))
//        Label("Spread the word that I code!", systemImage: "star")
//        
//        
//        let example = Image(.example)
//        
//        ShareLink(item: example, preview: SharePreview("Me and Isa", image: example)) {
//            Label("Click to share", systemImage: "star")
//        }
//        VStack {
//            PhotosPicker(selection: $pickerItems, maxSelectionCount: 5, matching: .any(of: [.images, .not(.screenshots)])) {
//                Label("Pick up to 5 Pictures", systemImage: "photo")
//            }
//            
//            ScrollView{
//                ForEach(0..<selectedImages.count, id: \.self) { i in
//                    selectedImages[i]
//                        .resizable()
//                        .scaledToFit()
//                }
//            }
//        }
//        .onChange(of: pickerItems) {
//            Task {
//                selectedImages.removeAll()
//                
//                for item in pickerItems {
//                    if let loadImage = try await item.loadTransferable(type: Image.self) {
//                        selectedImages.append(loadImage)
//                    }
//                }
//            }
//        }
//    }
//}

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var currentFilter = CIFilter.pixellate()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                HStack{
                    Text("Intensity:")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                
                HStack {
                    Button("Change Filer", action: changeFilter)
                }
                
                Spacer()
                
                // share the picture
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
    }
    func changeFilter(){
        
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    func applyProcessing(){
        currentFilter.scale = Float(filterIntensity)
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
}


#Preview {
    ContentView()
}
