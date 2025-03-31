//
//  UIKit_Button_BasicViewController.swift
//  DevLab
//
//  Created by Michael Borgmann on 19/03/2025.
//

#if os(iOS)

import UIKit
import Combine

class UIKit_Button_BasicViewController: UIViewController {
    
    @Published var toastMessage: String = ""
    @Published var subtitle: String? {
        didSet {
            self.title = subtitle
        }
    }
    
    private var label: UILabel!
    private var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subtitle = "Basic UIButton"
        
        setupLabel()
        setupButton()
    }
    
    private func setupLabel() {
        
        // Setup UILabel
        label = UILabel()
        label.text = "A basic button that triggers an action."
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        view.addSubview(label)
        
        // Set up layout constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // Setup accessibility
        label.accessibilityLabel = "A basic button that triggers an action."
        label.accessibilityHint = "Choose a button style from the list below."
    }
        
    private func setupButton() {
        
        // Setup UIButton
        button = UIButton(type: .system)
        button.setTitle("Tap Me", for: .normal)
        view.addSubview(button)
        
        // Setup Action
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Set up layout constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Setup accessibility
        button.accessibilityLabel = "A basic button that triggers an action."
        button.accessibilityHint = "Triggers an action when pressed."
        button.accessibilityTraits = .button
    }
    
    @objc private func buttonTapped() {
//        toastPublisher.send("Button Pressed")
        toastMessage = "Button Pressed"
    }
}

// MARK: - SwiftUI Representable

import SwiftUI

struct UIKit_Button_BasicViewControllerRepresentable: UIViewControllerRepresentable, DemoPage {
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    class Coordinator: NSObject {
        
        var parent: UIKit_Button_BasicViewControllerRepresentable
        var cancellables = Set<AnyCancellable>()
        
        init(parent: UIKit_Button_BasicViewControllerRepresentable) {
            self.parent = parent
        }
        
        func subscribe(to viewController: UIKit_Button_BasicViewController) {
            
            viewController.$toastMessage
                .receive(on: RunLoop.main)
                .sink { message in
                    if !message.isEmpty {
                        self.parent.viewModel.toastMessage = message
                        self.parent.viewModel.showToast = true

                        Task { @MainActor in
                            try? await Task.sleep(for: .seconds(1))
                            self.parent.viewModel.showToast = false
                        }
                    }
                }
                .store(in: &cancellables)
            
            viewController.$subtitle
                .receive(on: RunLoop.main)
                .sink { newSubtitle in
                    self.parent.viewModel.subtitle = newSubtitle
                }
                .store(in: &cancellables)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIKit_Button_BasicViewController {
        let viewController = UIKit_Button_BasicViewController()
        context.coordinator.subscribe(to: viewController)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIKit_Button_BasicViewController, context: Context) {
        // Handle any updates to the view controller if needed
    }
}

#Preview {
    @Previewable @State var viewModel = DemoViewModel()
    NavigationStack {
        UIKit_Button_BasicViewControllerRepresentable(viewModel: $viewModel, id: UUID())
    }
}

#endif
