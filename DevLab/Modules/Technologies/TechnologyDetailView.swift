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
    }
    
    private func technologyRows() -> some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                
                if technology.sections.isEmpty {
                    Text("No technology sections available.")
                        .padding()
                        .foregroundColor(.gray)
                } else {
                    ForEach(technology.sections) { section in
                        VStack(alignment: .leading) {
                            Text(section.name)
                                .font(.headline)
                                .padding(.top, 10)
                                .padding(.leading, 16)
                            
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
                } else {
                    ForEach(section.demos) { demo in
                        if let demoView = demoFactory(for: demo.view) {
                            NavigationLink(destination: demoView) {
                                demoCard(title: demo.title, colors: [.purple, .blue])
                            }
                        } else {
                            Button {
                                viewModel.error = TechnologyViewModel.Error.demoNotFound(demoName: demo.title)
                            } label: {
                                demoCard(title: demo.title, colors: [.red, .orange])
                            }
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
        case "SwiftUI_Button_DemoView":
            AnyView(SwiftUI_Button_DemoView(viewModel: $viewModel))
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
