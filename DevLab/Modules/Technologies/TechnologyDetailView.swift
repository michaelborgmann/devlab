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
                if !technology.sections.isEmpty {
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
                } else {
                    Text("No technology sections available.")
                        .padding()
                        .foregroundColor(.gray)
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
                        NavigationLink(destination: demoFactory(for: demo.view)) {
                            CardView(title: demo.title, background: AnyView(
                                LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            )
                        }
                    }
                }
                
                Spacer().frame(width: 0)
            }
        }
        .scrollClipDisabled()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder func demoFactory(for demoName: String) -> some View {
        switch demoName {
        case "SwiftUI_Button_DemoView":
            SwiftUI_Button_DemoView()
        default:
            VStack {
                Text("`\(demoName)` not found")
                    .foregroundColor(.red)
                    .onAppear {
                        viewModel.error = TechnologyViewModel.Error.demoNotFound(demoName: demoName)
                    }
                    .errorAlert(error: $viewModel.error)
            }
        }
    }
}

#Preview {
    
    let viewModel = TechnologyViewModel()
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
}
