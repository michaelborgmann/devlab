//
//  AppKit_NSButton_DemoViewController.swift
//  DevLab
//
//  Created by Michael Borgmann on 20/03/2025.
//

#if os(macOS)

import AppKit
import Combine

class AppKit_NSButton_BasicViewController: NSViewController {
    
    @Published var toastMessage: String = ""
    @Published var subtitle: String? {
        didSet {
            self.title = subtitle
        }
    }
    
    private var label: NSTextField!
    private var button: NSButton!
    
    override func loadView() {
        view = NSView()
        view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subtitle = "Basic NSButton"
        
        setupLabel()
        setupButton()
    }
    
    private func setupLabel() {
        label = NSTextField(labelWithString: "A basic button that triggers an action.")
        label.font = NSFont.preferredFont(forTextStyle: .headline)
        label.alignment = .center
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Accessibility
        label.setAccessibilityLabel("A basic button that triggers an action.")
//        label.setAccessibilityHint("Choose a button style from the list below.")
    }
    
    private func setupButton() {
        button = NSButton(title: "Tap Me", target: self, action: #selector(buttonTapped))
        button.bezelStyle = .rounded
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Accessibility
        button.setAccessibilityLabel("A basic button that triggers an action.")
//        button.setAccessibilityHint("Triggers an action when pressed.")
    }
    
    @objc private func buttonTapped() {
        toastMessage = "Button Pressed"
    }
}

// MARK: - SwiftUI Representable

import SwiftUI

struct AppKit_NSButton_BasicViewControllerRepresentable: NSViewControllerRepresentable {
    
    @Binding var showToast: Bool
    @Binding var toastMessage: String
    @Binding var subtitle: String?
    
    class Coordinator: NSObject {
        
        var parent: AppKit_NSButton_BasicViewControllerRepresentable
        var cancellables = Set<AnyCancellable>()
        
        init(parent: AppKit_NSButton_BasicViewControllerRepresentable) {
            self.parent = parent
        }
        
        func subscribe(to viewController: AppKit_NSButton_BasicViewController) {
            
            viewController.$toastMessage
                .receive(on: RunLoop.main)
                .sink { message in
                    if !message.isEmpty {
                        self.parent.toastMessage = message
                        self.parent.showToast = true

                        Task { @MainActor in
                            try? await Task.sleep(for: .seconds(1))
                            self.parent.showToast = false
                        }
                    }
                }
                .store(in: &cancellables)
            
            viewController.$subtitle
                .receive(on: RunLoop.main)
                .sink { newSubtitle in
                    self.parent.subtitle = newSubtitle
                }
                .store(in: &cancellables)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeNSViewController(context: Context) -> AppKit_NSButton_BasicViewController {
        let viewController = AppKit_NSButton_BasicViewController()
        context.coordinator.subscribe(to: viewController)
        return viewController
    }
    
    func updateNSViewController(_ nsViewController: AppKit_NSButton_BasicViewController, context: Context) {
        // Handle any updates to the view controller if needed
    }
}

#Preview {
    @Previewable @State var showToast = false
    @Previewable @State var toastMessage = ""
    @Previewable @State var subtitle: String? = nil
    
    NavigationStack {
        AppKit_NSButton_BasicViewControllerRepresentable(showToast: $showToast, toastMessage: $toastMessage, subtitle: $subtitle)
    }
}

#endif
