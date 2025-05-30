//
//  SpriteKit_SKScene_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 22/03/2025.
//

/*
#if os(iOS)

import SwiftUI
import SpriteKit
import PhotosUI



struct SpriteKit_SKScene_DemoView: DemoPage {
    
    @State private var spriteKitViewModel = SpriteKit_SKScene_ViewModel()
    @State private var gameScene: SpriteKit_SKScene_GameScene
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    init(viewModel: Binding<DemoViewModel>, id: UUID) {
        self._viewModel = viewModel
        self.id = id
        
        let sceneModel = SpriteKit_SKScene_ViewModel() // Create the ViewModel first
        self._spriteKitViewModel = State(initialValue: sceneModel)
        self._gameScene = State(initialValue: SpriteKit_SKScene_GameScene(viewModel: viewModel.wrappedValue, sceneModel: sceneModel))
    }
    
    var body: some View {
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
        .onChange(of: spriteKitViewModel.backgroundColor) { _, _ in
            gameScene.updateBackgroundColor()
        }
        .onChange(of: spriteKitViewModel.sceneWidth) { _, newWidth in
            gameScene.size.width = newWidth
        }
        .onChange(of: spriteKitViewModel.sceneHeight) { _, newHeight in
            gameScene.size.height = newHeight
        }
        .onChange(of: spriteKitViewModel.selectedImage) { _, _ in
            gameScene.updateBackgroundImage()
        }

        #if os(iOS)
        .sheet(isPresented: $viewModel.showCustomizations) {
            SpriteKit_SKScene_CustomizationView(viewModel: spriteKitViewModel)
                .presentationDetents([.medium])
                .accessibilityAddTraits(.isModal)
                .accessibilityLabel("Customization Options Sheet")
                .accessibilityHint("Customize various settings for the scene here.")
        }
        #endif
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    NavigationStack {
        SpriteKit_SKScene_DemoView(viewModel: $viewModel)
    }
}

#endif
*/
