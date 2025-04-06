//
//  SwiftUI_ObservedObject_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 06/04/2025.
//

import SwiftUI

class CounterModel: ObservableObject {
    @Published var count: Int = 0
}

struct SwiftUI_ObservedObject_DemoView: DemoPage {
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    @StateObject private var model = CounterModel()
    
    var body: some View {
            VStack(spacing: 30) {
                
                Text("@StateObject & @ObservedObject Demo")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
                
                // 🔵 Parent Section
                VStack(spacing: 10) {
                    HStack {
                        Text("Parent View")
                            .font(.subheadline)
                            .bold()
                        Text("@StateObject")
                            .monospaced()
                            .font(.caption)
                    }
                    Text("Count = \(model.count)")
                        .accessibilityLabel("Count value")
                        .accessibilityValue("\(model.count)")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .accessibilityElement(children: .combine)
                
                // 🟠 Child Section
                VStack(spacing: 16) {
                    HStack {
                        Text("Child View")
                            .font(.subheadline)
                            .bold()
                        Text("@ObservedObject")
                            .monospaced()
                            .font(.caption)
                    }
                    CounterControls(model: model)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
                .accessibilityElement(children: .contain)
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.subtitle = "@StateObject / @ObservedObject"
            }
        }
}

struct CounterControls: View {
    @ObservedObject var model: CounterModel

    var body: some View {
        HStack {
            Button("-") { model.count -= 1 }
            Button("+") { model.count += 1 }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_ObservedObject_DemoView(viewModel: $viewModel)
}
