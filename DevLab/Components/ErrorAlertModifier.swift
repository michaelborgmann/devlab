//
//  ErrorAlertModifier.swift
//  DevLab
//
//  Created by Michael Borgmann on 09/03/2025.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    
    @Binding var error: Error?
    var action: (() -> AnyView)?

    func body(content: Content) -> some View {
        content
            .alert(
                isPresented: Binding(
                    get: { error != nil },
                    set: { if !$0 { error = nil } }),
                error: error
                    .flatMap { $0 as? LocalizedError }
                    .map { AnyLocalizedError($0) },
                actions: { _ in action?() },
                message: { error in
                    if let failureReason = error.failureReason,
                       let recoverySuggestion = error.recoverySuggestion
                    {
                        Text("\(failureReason)\n\n\(recoverySuggestion)")
                    } else {
                        Text(error.localizedDescription)
                    }
                }
            )
    }
}

/// A modifier for showing an alert when an error occurs in your view.
///
/// This modifier provides an easy way to display error messages and perform actions
/// such as retrying, when an error is bound to a `@Binding` property. The alert will
/// show the `LocalizedError` description and additional information if available.
///
/// ### Example usage:
/// 1. **Without custom actions**:
/// Show an alert when `error` is not `nil` and automatically dismiss it when the user acknowledges.
///
/// ```swift
/// .errorAlert(error: $viewModel.error)
/// ```
///
/// 2. **With custom actions**:
/// Provide custom actions like a "Retry" button when an error is present. This button allows retrying an action or any other user-defined functionality.
///
/// ```swift
/// .errorAlert(error: $viewModel.error) {
///     Button("Retry") {
///         viewModel.retry()  // Example retry action
///     }
/// }
/// ```
///
/// ### Parameters:
/// - `error`: A `Binding` to an optional `Error?` that represents the error to display. When this error becomes `nil`, the alert will dismiss automatically.
/// - `action`: An optional closure that provides custom action buttons, if needed.
extension View {
    
    func errorAlert(error: Binding<Error?>) -> some View {
        modifier(ErrorAlertModifier(error: error, action: nil))
    }
    
    func errorAlert(error: Binding<Error?>, @ViewBuilder action: @escaping () -> some View) -> some View {
        modifier(ErrorAlertModifier(error: error, action: { AnyView(action()) }))
    }
}

#Preview {
    @Previewable @State var error: Error? = TechnologyViewModel.Error.failedLoadingData(message: "mock error", filename: "filename.json")
    
    return Button("Show Custom Error Alert") {
        error = TechnologyViewModel.Error.failedLoadingData(message: "mock error", filename: "filename.json")
    }
    .errorAlert(error: $error)
}
