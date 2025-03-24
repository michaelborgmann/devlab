//
//  SpriteKit_SKScene_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 22/03/2025.
//

import SwiftUI
import SpriteKit
import PhotosUI

extension SKSceneScaleMode: @retroactive CaseIterable {
    public static var allCases: [SKSceneScaleMode] {
        return [.fill, .aspectFill, .aspectFit, .resizeFill]
    }
    
    var displayName: String {
        switch self {
        case .fill: return "Fill"
        case .aspectFill: return "Aspect Fill"
        case .aspectFit: return "Aspect Fit"
        case .resizeFill: return "Resize Fill"
        @unknown default: return "Unknown"
        }
    }
}

@Observable
class DemoViewModel {
    var showInfo = false
    var subtitle: String?
    var showCustomizations = false
    var customizeAction: (() -> Void)? = nil
    
    var backgroundColor: Color = .orange
    var sceneWidth: CGFloat = .zero
    var sceneHeight: CGFloat = .zero
    var scaleMode: SKSceneScaleMode = .aspectFill
    var selectedPhoto: PhotosPickerItem? = nil
    var selectedImage: UIImage? = nil
}

struct SpriteKit_SKScene_DemoView: View {
    
    @State var viewModel: DemoViewModel
    @State private var gameScene: SpriteKit_SKScene_GameScene
    
    init(viewModel: DemoViewModel = DemoViewModel()) {
        self.viewModel = viewModel
        self._gameScene = State(initialValue: SpriteKit_SKScene_GameScene(viewModel: viewModel))
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
        .onChange(of: viewModel.backgroundColor) { _, _ in
            gameScene.updateBackgroundColor()
        }
        .onChange(of: viewModel.sceneWidth) { _, newWidth in
            gameScene.size.width = newWidth
        }
        .onChange(of: viewModel.sceneHeight) { _, newHeight in
            gameScene.size.height = newHeight
        }
        .onChange(of: viewModel.selectedImage) { _, _ in
            gameScene.updateBackgroundImage()
        }
        .toolbar {
            
            // NOTE: iOS only, centers subtitle in navigation bar.
            #if os(iOS)
            ToolbarItem(placement: .principal) {
                viewModel.subtitle.map {
                    Text($0)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .accessibilityLabel($0)
                }
            }
            #endif
            
            // NOTE: Show demo information.
            #if os(macOS)
            ToolbarItemGroup(placement: .automatic) {
                
                if let customizeAction = customizeAction {
                    Button { customizeAction() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Open customization options to modify scene settings")
                    .accessibilityHint("Tapping this opens customization options for the scene")
                }
                
                NavigationLink(destination: {
                    SwiftUI_Button_InfoView()
                }, label: {
                    Image(systemName: "info.circle")
                })
                .accessibilityLabel("Open the information sheet to learn more about this demo")
                .accessibilityHint("Tapping this opens the information sheet with details about the demo and how it works")
                .accessibilityValue(viewModel.showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
            
            #elseif os(iOS)
            ToolbarItemGroup(placement: .topBarTrailing) {
                
                if viewModel.customizeAction != nil {
                    Button {
                        viewModel.showCustomizations.toggle()
                    }
                    label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .accessibilityLabel("Open customization options to modify scene settings")
                    .accessibilityHint("Tapping this opens customization options for the scene")

                }
                
                Button {
                    viewModel.showInfo.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
                .accessibilityLabel("Open the information sheet to learn more about this demo")
                .accessibilityHint("Tapping this opens the information sheet with details about the demo and how it works")
                .accessibilityValue(viewModel.showInfo ? "Information sheet is open" : "Information sheet is closed")
            }
            #endif
        }
        .sheet(isPresented: $viewModel.showInfo) {
            SpriteKit_SKScene_InfoView()
                .presentationSizing(.page)
                .accessibilityLabel("Information Sheet")
                .accessibilityHint("This sheet provides additional information about the demo and how it works.")
        }
        #if os(iOS)
        .animation(.easeInOut(duration: 0.3), value: viewModel.showCustomizations)
        .sheet(isPresented: $viewModel.showCustomizations) {
            SpriteKit_SKScene_CustomizationView(viewModel: viewModel)
                .presentationDetents([.medium])
                .accessibilityAddTraits(.isModal)
                .accessibilityLabel("Customization Options Sheet")
                .accessibilityHint("Customize various settings for the scene here.")
        }
        .navigationBarTitleDisplayMode(viewModel.showCustomizations ? .inline : .automatic)
        #endif
        .navigationTitle("SKScene")
        .accessibilityLabel("SKScene Demo")
        .accessibilityHint("This is a demo where you can customize and interact with a SpriteKit scene.")
    }
}

#Preview {
    NavigationStack {
        SpriteKit_SKScene_DemoView()
    }
}
