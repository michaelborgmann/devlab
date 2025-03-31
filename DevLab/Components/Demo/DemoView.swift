//
//  DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

// MARK: - Demo ViewModel

@Observable
class DemoViewModel {
    var showInfo = false
    var subtitle: String?
    var showCustomizations = false
    var customizeAction: (() -> Void)? = nil
    var showToast = false
    var toastMessage = ""
}

// MARK: - Base Demo View

struct DemoView: View {
    
    let demo: DemoProtocol
    @State private var viewModel = DemoViewModel()
    @State private var demos: [any DemoPage] = []
    
    var body: some View {
        VStack {
            
            // Spacer ensures the VStack has a valid intrinsic height to layout the TabView correctly.
            Spacer()
            
            TabView {
                ForEach(demos, id: \.id) { page in
                    AnyView(page)
                }
            }
            #if os(iOS)
            .pageTab()
            #elseif os(macOS)
            .sidebar()
            #endif
            .overlay {
                Text(viewModel.toastMessage)
                    .toast(showToast: $viewModel.showToast, toastMessage: $viewModel.toastMessage)
            }
        }
        .onAppear {
            demos = demo.createDemos(viewModel: $viewModel)
        }
        .toolbar {
            #if os(iOS)
            toolbarSubtitle
            #endif
            toolbarActions
        }
        #if os(iOS)
        .sheet(isPresented: $viewModel.showInfo) {
            InfoView(fileName: demo.infoFileName, fileType: "md")
                .presentationSizing(.page)
        }
        #endif
        .animation(.easeInOut, value: viewModel.showToast)
        .navigationTitle(demo.title)
    }
    
    @ToolbarContentBuilder
    private var toolbarSubtitle: some ToolbarContent {
        
        // NOTE: iOS only, centers subtitle in navigation bar.
        ToolbarItem(placement: .principal) {
            viewModel.subtitle.map {
                Text($0)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    #if os(iOS)
    @ToolbarContentBuilder
    private var toolbarActions: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            
            if let customizeAction = viewModel.customizeAction {
                Button { customizeAction() } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
            
            Button { viewModel.showInfo.toggle() } label: {
                Image(systemName: "info.circle")
            }
        }
    }
    #endif
    
    #if os(macOS)
    @ToolbarContentBuilder
    private var toolbarActions: some ToolbarContent {
        ToolbarItemGroup(placement: .automatic) {
            
            if let customizeAction = viewModel.customizeAction {
                Button { customizeAction() } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                .accessibilityLabel("Customize Settings")
                .accessibilityHint("Opens customization options")
            }
            
            NavigationLink(destination: {
                InfoView(fileName: demo.infoFileName, fileType: "md")
            }, label: {
                Image(systemName: "info.circle")
            })
            .accessibilityLabel("Show Information")
            .accessibilityHint("Opens the info sheet with details about the demo.")
            .accessibilityValue(viewModel.showInfo ? "Information sheet is open" : "Information sheet is closed")
        }
    }
    #endif
}

// MARK: - Extensions

extension View {
    
    #if os(iOS)
    @ViewBuilder
    func pageTab() -> some View {
        self.tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    #endif
    
    #if os(macOS)
    @ViewBuilder
    func sidebar() -> some View {
        self.buttonStyle(.plain)
            .tabViewStyle(.sidebarAdaptable)
    }
    #endif
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DemoView(demo: SwiftUI_Button_Demo())
    }
}
