//
//  DummyDemoPageView.swift
//  DevLab
//
//  Created by Michael Borgmann on 31/03/2025.
//

import SwiftUI

protocol DemoPage: View, Identifiable {
    var id: UUID { get }
    init(viewModel: Binding<DemoViewModel>, id: UUID)
}

extension DemoPage {
    init(viewModel: Binding<DemoViewModel>) {
        self.init(viewModel: viewModel, id: UUID())
    }
}

struct DummyDemoPageView: DemoPage {
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Just a dummy demo view")
                .font(.headline)
        }
        .padding()
        .onAppear {
            viewModel.subtitle = "Dummy Demo"
        }
    }
}

#Preview {
    NavigationStack {
        DummyDemoPageView(viewModel: .constant(DemoViewModel()))
    }
}
