//
//  React_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 21/03/2025.
//

import SwiftUI

struct React_Basic_DemoView: DemoPage {
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var demoURL: URL? {
        URL(string: "https://hacknthrash.github.io/react-demos/")
    }
    
    var body: some View {
        if let demoURL = demoURL {
            WebView(url: demoURL)
                .accessibilityLabel("React Demo Web Page")
                .accessibilityHint("Displays a demo of React applications.")
        } else {
            Text("Failed to load demo.")
                .accessibilityLabel("Demo loading failed")
                .accessibilityHint("The page could not be loaded, please check your connection or try again.")
        }
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    NavigationStack {
        React_Basic_DemoView(viewModel: $viewModel)
    }
}
