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
        case "SwiftUI_Button_Demo":
            AnyView(DemoView(demo: SwiftUI_Button_Demo()))
        case "SwiftUI_Toggle_Demo":
            AnyView(DemoView(demo: SwiftUI_Toggle_Demo()))
        case "SwiftUI_Stepper_Demo":
            AnyView(DemoView(demo: SwiftUI_Stepper_Demo()))
        case "SwiftUI_Slider_Demo":
            AnyView(DemoView(demo: SwiftUI_Slider_Demo()))
        case "SwiftUI_Picker_Demo":
            AnyView(DemoView(demo: SwiftUI_Picker_Demo()))
        case "SwiftUI_TextField_Demo":
            AnyView(DemoView(demo: SwiftUI_TextField_Demo()))
        case "SwiftUI_DatePicker_Demo":
            AnyView(DemoView(demo: SwiftUI_DatePicker_Demo()))
        case "SwiftUI_State_Demo":
            AnyView(DemoView(demo: SwiftUI_State_Demo()))
        case "SwiftUI_Binding_Demo":
            AnyView(DemoView(demo: SwiftUI_Binding_Demo()))
        case "SwiftUI_ObservedObject_Demo":
            AnyView(DemoView(demo: SwiftUI_ObservedObject_Demo()))
        case "SwiftUI_StateObject_Demo":
            AnyView(DemoView(demo: SwiftUI_StateObject_Demo()))
        case "SwiftUI_EnvironmentObject_Demo":
            AnyView(DemoView(demo: SwiftUI_EnvironmentObject_Demo()))
            
        // UIKit
        #if os(iOS)
        case "UIKit_UIButton_Demo":
            AnyView(DemoView(demo: UIKit_UIButton_Demo()))
        #endif
        
        // AppKit
        #if os(macOS)
        case "AppKit_NSButton_Demo":
            AnyView(DemoView(demo: AppKit_NSButton_Demo()))
        #endif
        
        // SpriteKit
        case "SpriteKit_SKScene_Demo":
            AnyView(DemoView(demo: SpriteKit_SKScene_Demo()))
            
        // Angular
        case "Angular_Basic_Demo":
            AnyView(DemoView(demo: Angular_Basic_Demo()))
            
        // React
        case "React_Basic_Demo":
            AnyView(DemoView(demo: React_Basic_Demo()))
        
        // Vue.js
        case "VueJS_Basic_Demo":
            AnyView(DemoView(demo: VueJS_Basic_Demo()))
            
        default:
            nil
        }
    }
}

#Preview {
    
    @Previewable var viewModel = TechnologyViewModel()
    try? viewModel.loadTechnologies()
    
    return NavigationView {
        if let ecosystem = viewModel.ecosystems.first,
           let technology = ecosystem.technologies.first
        {
            TechnologyDetailView(viewModel: .constant(viewModel), technology: technology)
        } else {
            Text("No ecosystem")
        }
    }
    .errorAlert(error: .constant(viewModel.error))
}
