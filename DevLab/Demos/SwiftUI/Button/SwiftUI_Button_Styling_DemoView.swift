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

struct SwiftUI_Button_Styling_DemoView: DemoPage {
    
    @State private var selectedStyle: SwiftUI_ButtonStyleType = .automatic
    @State private var customizerViewModel = SwiftUI_Button_DemoViewModel()
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    @Namespace private var animationNamespace
    
    private func setupCustomizeAction() {
        viewModel.customizeAction = {
            withAnimation(.easeInOut(duration: 0.3)) {
                customizerViewModel.showCustomizations.toggle()
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
            if customizerViewModel.showCustomizations {
                
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
            viewModel.subtitle = "Button Styling"
            
            #if os(macOS)
            viewModel.showCustomizations = true
            #endif
            
            setupCustomizeAction()
        }
        .onDisappear {
            viewModel.customizeAction = nil
        }
        .onChange(of: customizerViewModel.selectedPhoto) { _, newItem in
            
            newItem?.loadTransferable(type: Image.self) { result in
                Task {
                    switch result {
                    case .success(let image):
                        if let image = image {
                            await customizerViewModel.selectedImage = image
                        }
                    case .failure:
                        break
                    }
                }
            }
        }
        #if os(iOS)
        .animation(.easeInOut(duration: 0.3), value: customizerViewModel.showCustomizations)
        .sheet(isPresented: $customizerViewModel.showCustomizations) {
            customizeButton
                .presentationDetents([.medium])
                .accessibilityAddTraits(.isModal)
        }
        .navigationBarTitleDisplayMode(customizerViewModel.showCustomizations ? .inline : .automatic)
        #endif
    }
    
    private func showToastMessage() {
        
        viewModel.toastMessage = "Button Pressed"
        viewModel.showToast = true
        
        Task {
            try? await Task.sleep(for: .seconds(1))
            viewModel.showToast = false
        }
    }
    
    @ViewBuilder var styledButton: some View {
        Button(customizerViewModel.title) {
            showToastMessage()
        }
        .buttonStyle(SwiftUI_CustomButtonStyle(viewModel: $customizerViewModel))
        .accessibilityLabel("Styled Button")
        .accessibilityHint("Taps this button to trigger an action.")
        .accessibilityAddTraits(.isButton)
    }
    
    @ViewBuilder var customizeButton: some View {
        
        NavigationStack {
            List {
                
                Section(header: Text("Button Title")) {
                    
                    TextField("Title", text: $customizerViewModel.title)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Button Title")
                        .accessibilityHint("Enter a title for the button")
                    
                    ColorPicker("Font Color", selection: $customizerViewModel.fontColor)
                        .accessibilityLabel("Font Color")
                    
                    Picker("Font Style:", selection: $customizerViewModel.selectedFont) {
                        ForEach(SwiftUI_Button_DemoViewModel.TextSize.allCases, id: \.self) { font in
                            Text(font.rawValue).tag(font.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    .accessibilityLabel("Font Style Picker")
                    .accessibilityHint("Choose a font style for the button")
                    .accessibilityValue(customizerViewModel.selectedFont.rawValue)
                }
                
                Section(header: Text("Button Shape")) {
                    
                    VStack(spacing: 0) {
                        Text("Padding: \(Int(customizerViewModel.padding))")
                        Slider(value: $customizerViewModel.padding, in: 8...32)
                            .accessibilityLabel("Button Padding")
                            .accessibilityValue("\(Int(customizerViewModel.padding)) pixels")
                    }
                    
                    VStack(spacing: 0) {
                        Text("Corner Radius: \(Int(customizerViewModel.cornerRadius))")
                        Slider(value: $customizerViewModel.cornerRadius, in: 0...30)
                            .accessibilityLabel("Corner Radius")
                            .accessibilityValue("\(Int(customizerViewModel.cornerRadius)) pixels")
                    }
                    
                    VStack(spacing: 0) {
                        Text("Shadow: \(Int(customizerViewModel.shadow))")
                        Slider(value: $customizerViewModel.shadow, in: 0...20)
                            .accessibilityLabel("Shadow Intensity")
                            .accessibilityValue("\(Int(customizerViewModel.shadow)) pixels")
                    }
                }
                
                Section(header: Text("Button Background")) {
                    
                    VStack {
                        Picker("Button Background:", selection: $customizerViewModel.selectedBackground) {
                            ForEach(SwiftUI_Button_DemoViewModel.Background.allCases, id: \.self) { style in
                                Text(style.rawValue).tag(style.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .accessibilityLabel("Button Background Style")
                        .accessibilityHint("Select a background type for the button")
                        .accessibilityValue(customizerViewModel.selectedBackground.rawValue)
                        
                        switch customizerViewModel.selectedBackground {
                        case .color:
                            ColorPicker("Background Color", selection: $customizerViewModel.backgroundColor)
                                .accessibilityLabel("Background Color")
                        case .gradient:
                            ColorPicker("Start Color", selection: $customizerViewModel.gradientStart)
                                .accessibilityLabel("Gradient Start Color")
                            ColorPicker("End Color", selection: $customizerViewModel.gradientEnd)
                                .accessibilityLabel("Gradient End Color")
                        case .image:
                            PhotosPicker("Select Background Image", selection: $customizerViewModel.selectedPhoto)
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
    @Previewable @State var viewModel = DemoViewModel()
    
    NavigationStack {
        SwiftUI_Button_Styling_DemoView(viewModel: $viewModel)
            .navigationTitle("Button")
            .toolbar {
                ToolbarItem {
                    Button { viewModel.customizeAction!() } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .overlay {
                Text(viewModel.toastMessage)
                    .toast(showToast: $viewModel.showToast, toastMessage: $viewModel.toastMessage)
            }
            .animation(.easeInOut, value: viewModel.showToast)
    }
}
