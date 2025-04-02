//
//  SpriteKit_SKScene_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/04/2025.
//

import SwiftUI
import SpriteKit
import PhotosUI

@Observable
class SpriteKit_SKScene_ViewModel {
    
    var backgroundColor: Color = .orange
    var sceneWidth: CGFloat = .zero
    var sceneHeight: CGFloat = .zero
    var scaleMode: SKSceneScaleMode = .aspectFill
    var selectedPhoto: PhotosPickerItem? = nil
    #if os(iOS)
    var selectedImage: UIImage? = nil
    #elseif os(macOS)
    var selectedImage: NSImage? = nil
    #endif
}

struct SpriteKit_SKScene_Basic_DemoView: DemoPage {
    
    @State private var sceneModel = SpriteKit_SKScene_ViewModel()
    @State private var gameScene: SpriteKit_SKScene_GameScene
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    init(viewModel: Binding<DemoViewModel>, id: UUID) {
        self._viewModel = viewModel
        self.id = id
        
        let sceneModel = SpriteKit_SKScene_ViewModel() // Create the ViewModel first
        self._sceneModel = State(initialValue: sceneModel)
        self._gameScene = State(initialValue: SpriteKit_SKScene_GameScene(viewModel: viewModel.wrappedValue, sceneModel: sceneModel))
    }
    
    private func setupCustomizeAction() {
        viewModel.customizeAction = {
            Task { @MainActor in
                viewModel.showCustomizations.toggle()
            }
        }
    }
    
    var body: some View {
        
        content
        .onAppear {
            viewModel.subtitle = "SKScene Basic"
            
            #if os(macOS)
            viewModel.showCustomizations = true
            #endif
            
            setupCustomizeAction()
        }
        .onDisappear {
            viewModel.customizeAction = nil
        }
        .onChange(of: sceneModel.backgroundColor) { _, _ in
            gameScene.updateBackgroundColor()
        }
        .onChange(of: sceneModel.sceneWidth) { _, newWidth in
            gameScene.size.width = newWidth
        }
        .onChange(of: sceneModel.sceneHeight) { _, newHeight in
            gameScene.size.height = newHeight
        }
        .onChange(of: sceneModel.selectedImage) { _, _ in
            gameScene.updateBackgroundImage()
        }
        #if os(iOS)
        .sheet(isPresented: $viewModel.showCustomizations) {
            SpriteKit_SKScene_CustomizationView(viewModel: sceneModel)
                .presentationDetents([.medium])
                .accessibilityAddTraits(.isModal)
        }
        #endif
    }
    
    @ViewBuilder
    private var content: some View {
        #if os(macOS)
        HSplitView {
            gameSceneView

            if viewModel.showCustomizations {
                SpriteKit_SKScene_CustomizationView(viewModel: sceneModel)
                    .frame(width: 400)
            }
        }
        #else
        gameSceneView
        #endif
    }
    
    @ViewBuilder
    private var gameSceneView: some View {
        ZStack {
            
            SpriteView(
                scene: gameScene,
                debugOptions: [.showsFPS, .showsNodeCount, .showsPhysics])
                .ignoresSafeArea()
                .accessibilityLabel("Interactive game scene demo")
                .accessibilityHint("Tap or interact with the scene for customization")
            
            VStack {
                
                Text("Touch screen and customize SKScene view")
                    .foregroundColor(.secondary)
                    .font(.body)
                    .bold()
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .opacity(0.1)
                    }
                    .accessibilityLabel("Instructions for customizing the scene")
                    .accessibilityHint("Read this text to understand how to customize the scene")
  
                Spacer()
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SpriteKit_SKScene_Basic_DemoView(viewModel: $viewModel)
}
