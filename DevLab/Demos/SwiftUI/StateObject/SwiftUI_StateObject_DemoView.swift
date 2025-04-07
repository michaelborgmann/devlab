//
//  SwiftUI_StateObject_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/04/2025.
//

import SwiftUI

final class PersistentCounterModel: ObservableObject {
    @Published var count: Int = 0
    let id = UUID()
}

struct SwiftUI_StateObject_DemoView: DemoPage {

    @Binding var viewModel: DemoViewModel
    let id: UUID

    @State private var showAlternate: Bool = false
    @StateObject private var model = PersistentCounterModel() // 👈 Ownership here

    var body: some View {
        VStack(spacing: 30) {

            Text("@StateObject: ViewModel Persists Across View Switches")
                .font(.headline)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center) // optional, for full-width centering
                .accessibilityAddTraits(.isHeader)

            Spacer()

            Button(action: {
                showAlternate.toggle()
            }) {
                Text(showAlternate ? "Switch to View A" : "Switch to View B")
                    .font(.subheadline)
                    .padding()
            }

            if showAlternate {
                StateObjectChildView(label: "View B", model: model)
            } else {
                StateObjectChildView(label: "View A", model: model)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.subtitle = "@StateObject Ownership"
        }
    }
}
struct StateObjectChildView: View {
    let label: String
    @ObservedObject var model: PersistentCounterModel

    var body: some View {
        VStack(spacing: 16) {
            Text(label)
                .font(.subheadline)
                .bold()

            Text("Counter: \(model.count)")
            Text("Model ID: \(model.id.uuidString.prefix(6))") // 👈 UI proof

            HStack(spacing: 20) {
                Button(action: { model.count -= 1 }) {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.red)
                }

                Button(action: { model.count += 1 }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    SwiftUI_StateObject_DemoView(viewModel: $viewModel)
}
