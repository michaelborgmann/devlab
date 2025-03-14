//
//  ToastModifier.swift
//  DevLab
//
//  Created by Michael Borgmann on 14/03/2025.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    @Binding var showToast: Bool
    
    func body(content: Content) -> some View {
        if showToast {
            content
                .padding()
                .background(Color.black.opacity(0.7), in: RoundedRectangle(cornerRadius: 10))
                .foregroundColor(.white)
                .transition(.move(edge: .bottom))
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

/// A modifier for showing a temporary toast message in your view.
///
/// This modifier provides an easy way to display a brief message (toast) at the bottom of the screen.
/// The toast will slide in when `showToast` is `true` and disappear when set to `false`.
///
/// ### Example usage:
///
/// #### **1. Simple Toast Message**
/// Show a toast message when `showToast` is `true`. The message appears at the bottom and hides when `showToast` is `false`.
///
/// ```swift
/// .toast(showToast: $showToast)
/// ```
///
/// #### **2. Displaying a Toast Message on Button Press**
/// Automatically show and hide a toast when a button is tapped.
///
/// ```swift
/// Button("Show Toast") {
///     toastMessage = "Button Pressed!"
///     showToast = true
///
///     Task {
///         try? await Task.sleep(for: .seconds(1)) // Modern Swift Concurrency
///         showToast = false
///     }
/// }
/// .toast(showToast: $showToast)
/// ```
///
/// #### **3. Alternative Using DispatchQueue**
/// If you prefer using `DispatchQueue`, you can achieve the same result:
///
/// ```swift
/// Button("Show Toast") {
///     toastMessage = "Button Pressed!"
///     showToast = true
///
///     DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
///         showToast = false
///     }
/// }
/// .toast(showToast: $showToast)
/// ```
///
/// #### **4. Using Toast with a ViewModel**
/// If managing UI state in a ViewModel, you can bind `showToast` to a property:
///
/// ```swift
/// .toast(showToast: $viewModel.showToast)
/// ```
///
/// ### Parameters:
/// - `showToast`: A `Binding<Bool>` controlling the visibility of the toast message. The toast appears when `true` and disappears when `false`.
///
/// ### Notes:
/// - **Toast does not auto-dismiss by default.** You must manually set `showToast = false`, either using `Task.sleep` (recommended) or `DispatchQueue`.
/// - **Swift Concurrency (`Task.sleep`) is preferred** because it is **cancellable** and integrates better with SwiftUI.
/// - **Styling options:** You can customize the toast’s appearance by modifying `ToastModifier`.
///
/// ### Example in a Button View:
///
/// ```swift
/// struct ExampleView: View {
///     @State private var showToast = false
///     @State private var toastMessage = "Hello!"
///
///     var body: some View {
///         VStack {
///             Button("Show Toast") {
///                 toastMessage = "Button Pressed!"
///                 showToast = true
///
///                 Task {
///                     try? await Task.sleep(for: .seconds(2)) // Auto-dismiss after 2 seconds
///                     showToast = false
///                 }
///             }
///             .toast(showToast: $showToast)
///         }
///     }
/// }
/// ```
extension View {
    @ViewBuilder func toast(showToast: Binding<Bool>) -> some View {
        modifier(ToastModifier(showToast: showToast))
    }
}

#Preview {
    @Previewable @State var showToast: Bool = true
    Text("Toast Message")
        .toast(showToast: $showToast)
}
