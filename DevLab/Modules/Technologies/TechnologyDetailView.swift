//
//  TechnologyDetailView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

struct TechnologyDetailView: View {
    
    @Binding var viewModel: TechnologyViewModel
    let technology: Technology
    
    var body: some View {
        technologyRows()
            .navigationTitle(technology.name)
            .accessibilityLabel("Technology details for \(technology.name).")
            .accessibilityHint("Displays available sections and demos for the selected technology.")
    }
    
    private func technologyRows() -> some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                
                if technology.sections.isEmpty {
                    Text("No technology sections available.")
                        .padding()
                        .foregroundColor(.gray)
                        .accessibilityLabel("No sections available for this technology.")
                        .accessibilityHint("There are no sections to display.")
                } else {
                    ForEach(technology.sections) { section in
                        VStack(alignment: .leading) {
                            Text(section.name)
                                .font(.headline)
                                .padding(.top, 10)
                                .padding(.leading, 16)
                                .accessibilityLabel("Section: \(section.name)")
                                .accessibilityHint("Tap to see demos related to this section.")
                            
                            horizontalScroller(for: section)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
        }
    }
    
    private func horizontalScroller(for section: TechnologySection) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                
                Spacer().frame(width: 0)
                
                if section.demos.isEmpty {
                    Text("No demos available for this section.")
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                        .accessibilityLabel("No demos available.")
                        .accessibilityHint("There are no demos to show for this section.")
                } else {
                    ForEach(section.demos) { demo in
                        if let demoView = demoFactory(for: demo.view) {
                            NavigationLink(destination: demoView) {
                                demoCard(title: demo.title, colors: [.purple, .blue])
                                    .accessibilityLabel("Demo: \(demo.title)")
                                    .accessibilityHint("Tap to view the demo titled \(demo.title).")
                            }
                            .buttonStyle(.plain)
                        } else {
                            Button {
                                viewModel.error = TechnologyViewModel.Error.demoNotFound(demoName: demo.title)
                            } label: {
                                demoCard(title: demo.title, colors: [.red, .orange])
                                    .accessibilityLabel("Demo: \(demo.title)")
                                    .accessibilityHint("This demo is currently unavailable.")
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    Spacer().frame(width: 0)
                }
            }
        }
        .scrollClipDisabled()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func demoCard(title: String, colors: [Color]) -> some View {
        CardView(
            title: title,
            background: AnyView(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        )
    }
    
    func demoFactory(for demoName: String) -> AnyView? {
        switch demoName {
        
        // SwiftUI
        case "SwiftUI_Button_DemoView":
            AnyView(SwiftUI_Button_DemoView())
        case "SwiftUI_Toggle_DemoView":
            AnyView(SwiftUI_Toggle_DemoView())
        case "SwiftUI_Stepper_DemoView":
            AnyView(SwiftUI_Stepper_DemoView())
        case "SwiftUI_Slider_DemoView":
            AnyView(SwiftUI_Slider_DemoView())
        case "SwiftUI_Picker_DemoView":
            AnyView(SwiftUI_Picker_DemoView())
        case "SwiftUI_TextField_DemoView":
            AnyView(SwiftUI_TextField_DemoView())
        case "SwiftUI_DatePicker_DemoView":
            AnyView(SwiftUI_DatePicker_DemoView())
            
        // UIKit
        #if os(iOS)
        case "UIKit_UIButton_DemoView":
            AnyView(UIKit_UIButton_DemoView())
            
        // SpriteKit
        case "SpriteKit_SKScene_DemoView":
            AnyView(SpriteKit_SKScene_DemoView())
        #endif
        
        // AppKit
        #if os(macOS)
        case "AppKit_NSButton_DemoView":
            AnyView(AppKit_NSButton_DemoView())
        #endif
        
        // Angular
        case "Angular_Basic_DemoView":
            AnyView(Angular_Basic_DemoView())
            
        // React
        case "React_Basic_DemoView":
            AnyView(React_Basic_DemoView())
        
        // Vue.js
        case "VueJS_Basic_DemoView":
            AnyView(VueJS_Basic_DemoView())
            
        default:
            nil
        }
    }
}

#Preview {
    
    @Previewable var viewModel = TechnologyViewModel()
    try? viewModel.loadTechnologies()
    
    return NavigationView {
        if let ecosystem = viewModel.ecosystems.last,
           let technology = ecosystem.technologies.first
        {
            TechnologyDetailView(viewModel: .constant(viewModel), technology: technology)
        } else {
            Text("No ecosystem")
        }
    }
    .errorAlert(error: .constant(viewModel.error))
}
