//
//  SwiftUI_EnvironmentObject_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/04/2025.
//

import SwiftUI

struct SwiftUI_EnvironmentObject_DemoView: DemoPage {
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    @StateObject private var model = CounterModel()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Shared State Across Views with @EnvironmentObject")
                .font(.headline)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
            
            Text("In this demo, the `CounterModel` is shared across views using @EnvironmentObject. Watch how the counter persists and updates across different views.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
                .frame(maxWidth: .infinity)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            VStack {
                Text("Root View")
                    .font(.title2)
                    .foregroundColor(.cyan)
                
                Text("Counter value in Root View: \(model.count)")
                    .font(.body)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                
                ChildView()
                    .environmentObject(model)
            }
            
        }
        .padding()
        .onAppear {
            viewModel.subtitle = "@EnvironmentObject Demo"
        }
    }
}

struct ChildView: View {
    
    @EnvironmentObject var model: CounterModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Child View")
                .font(.title2)
                .foregroundColor(.orange)
            
            Text("Counter value in Child View: \(model.count)")
                .font(.body)
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
            
            HStack(spacing: 20) {
                Button(action: {
                    model.count -= 1
                }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    model.count += 1
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(10)
    }
}


#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_EnvironmentObject_DemoView(viewModel: $viewModel)
}
