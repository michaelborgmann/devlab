//
//  TechnologiesView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/03/2025.
//

import SwiftUI

struct TechnologiesView: View {
    
    @State var viewModel: TechnologyViewModel
    
    init(viewModel: TechnologyViewModel = TechnologyViewModel()) {
        self.viewModel = viewModel
    }
    
    private var selectedEcosystem: TechnologyEcosystem? {
        viewModel.ecosystems.first(where: { $0.name == viewModel.selectedEcosystem })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ecosystemPicker
                technologyRows()
            }
            .navigationTitle("Technologies")
            .accessibilityLabel("Technologies screen")
            .accessibilityHint("Select an ecosystem to view its technologies and demos.")
            .errorAlert(error: $viewModel.error)
        }
        .onAppear() {
            do {
                try viewModel.loadTechnologies()
            } catch {
                UIAccessibility.post(notification: .announcement, argument: "Failed to load technologies.")
            }
        }
    }
    
    // UI components
    
    private var ecosystemPicker: some View {
        Picker("Select a Technology Ecosystem", selection: $viewModel.selectedEcosystem) {
            ForEach(Array(viewModel.ecosystemNames), id: \.self) { ecosystem in
                Text(ecosystem).tag(ecosystem)
            }
        }
        .accessibilityLabel(LocalizedStringKey("Ecosystem Picker"))
        .accessibilityHint(LocalizedStringKey("Select a technology ecosystem to view the available technologies"))
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private func technologyRows() -> some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 20) {
                
                if let technologies = selectedEcosystem?.technologies, !technologies.isEmpty {
                    ForEach(technologies) { technology in
                        VStack(alignment: .leading) {
                            Text(technology.name)
                                .font(.headline)
                                .padding(.top, 10)
                                .padding(.leading, 16)
                                .accessibilityLabel("Technology: \(technology.name)")
                                .accessibilityHint("Tap to view sections and demos for this technology.")
                            
                            horizontalScrollingList(for: technology)
                        }
                        .padding(.bottom, 20)
                    }
                } else {
                    Text("No technologies available.")
                        .padding()
                        .foregroundColor(.gray)
                        .accessibilityLabel("No technologies available for the selected ecosystem.")
                        .accessibilityHint("There are no technologies available in this ecosystem.")
                }
            }
        }
    }
    
    private func horizontalScrollingList(for technology: Technology) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                
                Spacer().frame(width: 0)
                
                ForEach(technology.sections, id: \.id) { section in
                    
                    NavigationLink(destination: TechnologyDetailView(viewModel: $viewModel, technology: technology)) {
                        
                        CardView(title: section.name, background: AnyView(
                            LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        )
                    }
                }
                
                Spacer().frame(width: 0)
            }
        }
        .scrollClipDisabled()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TechnologiesView()
}
