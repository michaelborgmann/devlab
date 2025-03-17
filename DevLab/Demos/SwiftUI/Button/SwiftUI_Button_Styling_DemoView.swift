//
//  SwiftUI_Button_Styling_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI
import PhotosUI

@Observable
class SwiftUI_Button_DemoViewModel {
    
    var showCustomizations = false
    
    var title: String = "Button Title"
    var padding: CGFloat = 16
    var cornerRadius: CGFloat = 16
    var shadow: CGFloat = 10
    var fontColor: Color = .white
    var backgroundColor: Color = .blue
    var gradientStart: Color = .blue
    var gradientEnd: Color = .purple
    
    var selectedBackground: Background = .color
    var selectedPhoto: PhotosPickerItem? = nil
    var selectedImage: Image? = nil
    
    enum Background: String, CaseIterable {
        case color = "Color"
        case gradient = "Gradient"
        case image = "Image"
    }
    
    var selectedFont: TextSize = .title
    
    enum TextSize: String, CaseIterable {
        
        #if os(visionOS)
        case extraLargeTitle2
        case extraLargeTitle
        #endif
        
        case largeTitle
        case title
        case title2
        case title3
        case headline
        case subheadline
        case body
        case callout
        case caption
        case caption2
        case footnote
        
        var font: Font {
            switch self {
                
           #if os(visionOS)
            case .extraLargeTitle2:
                .extraLargeTitle2
            case .extraLargeTitle:
                .extraLargeTitle
            #endif
                
            case .largeTitle:
                .largeTitle
            case .title:
                .title
            case .title2:
                .title2
            case .title3:
                .title3
            case .headline:
                .headline
            case .subheadline:
                .subheadline
            case .body:
                .body
            case .callout:
                .callout
            case .caption:
                .caption
            case .caption2:
                .caption2
            case .footnote:
                .footnote
            }
        }
    }
}

struct SwiftUI_Button_Styling_DemoView: View {
    
    @State private var selectedStyle: ButtonStyleType = .automatic
    @State private var viewModel = SwiftUI_Button_DemoViewModel()
    
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    @Binding var subtitle: String?
    @Binding var customizeAction: (() -> Void)? 
    
    @Namespace private var animationNamespace
    
    private func setupCustomizeAction() {
        customizeAction = {
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.showCustomizations.toggle()
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            
            #if os(macOS)
            HSplitView{
                
                VStack {
                    Text("Customize the button by styling it.")
                        .font(.headline)
                        .accessibilityLabel("Customize Button Styling")

                    Spacer()
                    
                    styledButton
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if viewModel.showCustomizations {                    
                    customizeButton
                        .frame(width: 400)
                }
            }
            #elseif os(iOS)
            if viewModel.showCustomizations {
                
                styledButton
                    .matchedGeometryEffect(id: "button", in: animationNamespace)
                Spacer()
                
            } else {
                
                Text("Customize the button by styling it.")
                    .accessibilityLabel("Customize Button Styling")
                    .font(.headline)
                
                Spacer()
                styledButton
                    .matchedGeometryEffect(id: "button", in: animationNamespace)
                Spacer()
            }
            #endif
        }
        .onAppear {
            subtitle = "Button Styling"
            
            #if os(macOS)
            viewModel.showCustomizations = true
            #endif
            
            setupCustomizeAction()
        }
        .onDisappear {
            customizeAction = nil
        }
        .onChange(of: viewModel.selectedPhoto) { _, newItem in
            
            newItem?.loadTransferable(type: Image.self) { result in
                Task {
                    switch result {
                    case .success(let image):
                        if let image = image {
                            await viewModel.selectedImage = image
                        }
                    case .failure:
                        break
                    }
                }
            }
        }
        #if os(iOS)
        .animation(.easeInOut(duration: 0.3), value: viewModel.showCustomizations)
        .sheet(isPresented: $viewModel.showCustomizations) {
            customizeButton
                .presentationDetents([.medium])
                .accessibilityAddTraits(.isModal)
        }
        .navigationBarTitleDisplayMode(viewModel.showCustomizations ? .inline : .automatic)
        #endif
    }
    
    private func showToastMessage() {
        
        toastMessage = "Button Pressed"
        showToast = true
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            showToast = false
        }
    }
    
    @ViewBuilder var styledButton: some View {
        Button(viewModel.title) {
            showToastMessage()
        }
        .buttonStyle(SwiftUI_CustomButtonStyle(viewModel: $viewModel))
        .accessibilityLabel("Styled Button")
        .accessibilityHint("Taps this button to trigger an action.")
        .accessibilityAddTraits(.isButton)
    }
    
    @ViewBuilder var customizeButton: some View {
        
        NavigationStack {
            List {
                
                Section(header: Text("Button Title")) {
                    
                    TextField("Title", text: $viewModel.title)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Button Title")
                        .accessibilityHint("Enter a title for the button")
                    
                    ColorPicker("Font Color", selection: $viewModel.fontColor)
                        .accessibilityLabel("Font Color")
                    
                    Picker("Font Style:", selection: $viewModel.selectedFont) {
                        ForEach(SwiftUI_Button_DemoViewModel.TextSize.allCases, id: \.self) { font in
                            Text(font.rawValue).tag(font.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityLabel("Font Style Picker")
                    .accessibilityHint("Choose a font style for the button")
                    .accessibilityValue(viewModel.selectedFont.rawValue)
                }
                
                Section(header: Text("Button Shape")) {
                    
                    VStack(spacing: 0) {
                        Text("Padding: \(Int(viewModel.padding))")
                        Slider(value: $viewModel.padding, in: 8...32)
                            .accessibilityLabel("Button Padding")
                            .accessibilityValue("\(Int(viewModel.padding)) pixels")
                    }
                    
                    VStack(spacing: 0) {
                        Text("Corner Radius: \(Int(viewModel.cornerRadius))")
                        Slider(value: $viewModel.cornerRadius, in: 0...30)
                            .accessibilityLabel("Corner Radius")
                            .accessibilityValue("\(Int(viewModel.cornerRadius)) pixels")
                    }
                    
                    VStack(spacing: 0) {
                        Text("Shadow: \(Int(viewModel.shadow))")
                        Slider(value: $viewModel.shadow, in: 0...20)
                            .accessibilityLabel("Shadow Intensity")
                            .accessibilityValue("\(Int(viewModel.shadow)) pixels")
                    }
                }
                
                Section(header: Text("Button Background")) {
                    
                    VStack {
                        Picker("Button Background:", selection: $viewModel.selectedBackground) {
                            ForEach(SwiftUI_Button_DemoViewModel.Background.allCases, id: \.self) { style in
                                Text(style.rawValue).tag(style.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accessibilityLabel("Button Background Style")
                        .accessibilityHint("Select a background type for the button")
                        .accessibilityValue(viewModel.selectedBackground.rawValue)
                        
                        switch viewModel.selectedBackground {
                        case .color:
                            ColorPicker("Background Color", selection: $viewModel.backgroundColor)
                                .accessibilityLabel("Background Color")
                        case .gradient:
                            ColorPicker("Start Color", selection: $viewModel.gradientStart)
                                .accessibilityLabel("Gradient Start Color")
                            ColorPicker("End Color", selection: $viewModel.gradientEnd)
                                .accessibilityLabel("Gradient End Color")
                        case .image:
                            PhotosPicker("Select Background Image", selection: $viewModel.selectedPhoto)
                                .accessibilityLabel("Select Background Image")
                                .accessibilityHint("Pick an image from your library to use as a button background")
                        }
                    }
                }
            }
            .navigationTitle("Customize Button Style")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
        
    }
}

struct SwiftUI_CustomButtonStyle: ButtonStyle {
    
    @Binding var viewModel: SwiftUI_Button_DemoViewModel
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
        
        .font(viewModel.selectedFont.font)
        .padding(viewModel.padding)
        .background(
            Group {
                switch viewModel.selectedBackground {
                case .color:
                    viewModel.backgroundColor
                case .gradient:
                    LinearGradient(
                    gradient: Gradient(colors: [viewModel.gradientStart, viewModel.gradientEnd]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                case .image:
                    if let image = viewModel.selectedImage {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .cornerRadius(10)
                    } else {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        )
        .foregroundColor(viewModel.fontColor)
        .cornerRadius(viewModel.cornerRadius)
        .shadow(radius: viewModel.shadow)
    }
}

#Preview {
    @Previewable @State var showToast = false
    @Previewable @State var toastMessage = ""
    @Previewable @State var customizeAction: (() -> Void)? = nil
    
    NavigationStack {
        SwiftUI_Button_Styling_DemoView(showToast: $showToast, toastMessage: $toastMessage, subtitle: .constant(nil), customizeAction: $customizeAction)
            .navigationTitle("Button")
            .toolbar {
                ToolbarItem {
                    Button { customizeAction!() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .overlay {
                Text(toastMessage)
                    .toast(showToast: $showToast, toastMessage: $toastMessage)
            }
            .animation(.easeInOut, value: showToast)
    }
}
