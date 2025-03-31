//
//  Angular_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 19/03/2025.
//

import SwiftUI

struct Angular_Basic_DemoView: DemoPage {
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var demoURL: URL? {
        URL(string: "https://hacknthrash.github.io/angular-demos/")
    }
    
    var body: some View {
        if let demoURL = demoURL {
            WebView(url: demoURL)
                .accessibilityLabel("Angular Demo Web Page")
                .accessibilityHint("Displays a demo of Angular applications.")
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
        Angular_Basic_DemoView(viewModel: $viewModel)
    }
}
