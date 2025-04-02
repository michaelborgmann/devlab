//
//  SpriteKit_SKScene_CustomizationView.swift
//  DevLab
//
//  Created by Michael Borgmann on 24/03/2025.
//

import SwiftUI
import PhotosUI
import SpriteKit

struct SpriteKit_SKScene_CustomizationView: View {
    
    @Bindable var viewModel: SpriteKit_SKScene_ViewModel
    
    #if os(iOS)
    let screenSize = UIScreen.main.bounds.size
    #elseif os(macOS)
    let screenSize = NSScreen.main?.frame.size ?? CGSize(width: 800, height: 600) // Default size if no screen available
    #endif
    
    var body: some View {
        
        NavigationStack {
            List {
                
                Section(header: Text("Background Color")) {
                    ColorPicker("Background Color", selection: $viewModel.backgroundColor)
                        .accessibilityLabel("Background Color")
                        .accessibilityHint("Choose a background color for the scene")
                }
                
                Section(header: Text("Scene Size")) {
                    
                    VStack(spacing: 0) {
                        Stepper("Scene Width: \(Int(viewModel.sceneWidth))", value: $viewModel.sceneWidth)
                        Slider(
                            value: $viewModel.sceneWidth,
                            in: -screenSize.width...screenSize.width * 10
                        )
                        .accessibilityLabel("Scene Width")
                        .accessibilityValue("\(Int(viewModel.sceneWidth)) pixels")
                        .accessibilityHint("Use to adjust the width of the scene")
                    }
                    
                    VStack(spacing: 0) {
                        Stepper("Scene Height: \(Int(viewModel.sceneHeight))", value: $viewModel.sceneHeight)
                        Slider(
                            value: $viewModel.sceneHeight,
                            in: -screenSize.height...screenSize.height * 10
                        )
                        .accessibilityLabel("Scene Width")
                        .accessibilityValue("\(Int(viewModel.sceneWidth)) pixels")
                        .accessibilityHint("Drag to adjust the width of the scene")
                    }
                }
                
                Section(header: Text("Scale Mode")) {
                    Picker("Scale Mode:", selection: $viewModel.scaleMode) {
                        ForEach(SKSceneScaleMode.allCases, id: \.self) { mode in
                            Text(mode.displayName).tag(mode)
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityLabel("Scale Mode Picker")
                    .accessibilityHint("Select a scale mode for the scene's content")
                    .accessibilityValue(viewModel.scaleMode.displayName)
                }
                
                Section(header: Text("Add SKSpriteNode")) {
                    
                            PhotosPicker(selection: $viewModel.selectedPhoto, matching: .images) {
                                
                                if let image = viewModel.selectedImage {
                                
                                    ZStack(alignment: .topTrailing) {

                                        #if os(iOS)
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                        #elseif os(macOS)
                                        Image(nsImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                        #endif
                                        
                                        Button(action: {
                                            viewModel.selectedImage = nil
                                            viewModel.selectedPhoto = nil
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                                .font(.title2)
                                                .background {
                                                    Circle().fill(.white)
                                                }
                                        }
                                        .buttonStyle(.borderless)
                                        .accessibilityLabel("Clear selected image")
                                        .accessibilityHint("Removes the selected image and resets the picker")
                                        .accessibilityAction(named: "Remove selected image") {
                                            viewModel.selectedImage = nil
                                            viewModel.selectedPhoto = nil
                                        }
                                    }
                                } else {
                                    ZStack(alignment: .center) {
                                        Image(systemName: "photo.on.rectangle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(.gray.opacity(0.15))
                                        
                                        Image(systemName: "plus.square.fill")
                                            .foregroundColor(.blue)
                                            .font(.largeTitle)
                                            .background {
                                                Circle().fill(.white)
                                            }
                                    }
                                }
                            }
                            .onChange(of: viewModel.selectedPhoto) { _, newPhoto in
                                if let newPhoto {
                                    Task {
                                        if let data = try? await newPhoto.loadTransferable(type: Data.self) {
                                            
                                            #if os(iOS)
                                            if let uiImage = UIImage(data: data) {
                                                viewModel.selectedImage = uiImage
                                            }
                                            #elseif os(macOS)
                                            if let uiImage = NSImage(data: data) {
                                                viewModel.selectedImage = uiImage
                                            }
                                            #endif
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .accessibilityLabel("Select Background Image")
                            .accessibilityHint("Pick an image from your library to use as a background for the sprite node")
                }
            }
        }
    }
}

#Preview {
    SpriteKit_SKScene_CustomizationView(viewModel: SpriteKit_SKScene_ViewModel())
}
