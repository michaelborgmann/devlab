//
//  UIKit_Button_DemoViewController.swift
//  DevLab
//
//  Created by Michael Borgmann on 18/03/2025.
//

#if os(iOS)

class UIKit_Button_StylingViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .green
    }
}

class UIKit_Button_AnimationViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
}

enum ViewControllerError: LocalizedError {
    case failedLoadingView(viewController: String?)
    case failedLoadingPage(message: String, page: String)
    case invalidPageIndex(index: Int)
    
    var errorDescription: String? {
        switch self {
        case .failedLoadingView:
            return "Failed Loading View"
        case .failedLoadingPage:
            return "Failed loading page"
        case .invalidPageIndex:
            return "Invalid page index"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .failedLoadingView(let viewController):
            return "The `\(viewController ?? "ViewController")` failed to initialize correctly."
        case .failedLoadingPage(let message, let page):
            return "The page `\(page)` could not be loaded: \(message)"
        case .invalidPageIndex(let index):
            return "The page index \(index) is out of bounds."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .failedLoadingView(let viewController):
            return "Check the initialization logic for the `\(viewController ?? "ViewController")` or ensure dependencies are properly configured."
        case .failedLoadingPage:
            return "Verify the page data or retry loading the page."
        case .invalidPageIndex:
            return "Ensure that the page index is within the valid range."
        }
    }
}

class UIKit_Button_DemoViewController: UIViewController {
    
    private var pageViewController: UIPageViewController?
    private var pageControl = UIPageControl()
    private var subtitleLabel: UILabel!

    private var showInfo: Bool = false
//    private var showInfo = false {
//        didSet {
//            presentInfoViewController()
//        }
//    }
    
    private lazy var pages: [UIViewController] = {
        let basicVC = UIKit_Button_BasicViewController()
        let stylingVC = UIKit_Button_StylingViewController()
        let animationVC = UIKit_Button_AnimationViewController()
        return [basicVC, stylingVC, animationVC]
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupNavigationBar()
        
        do {
            try setupPageViewController()
        } catch {
            DispatchQueue.main.async {
                self.showErrorAlert(for: error)
            }
        }
    }
    
    private func setupNavigationBar() {
        
        // Subtitle Label
        subtitleLabel = UILabel()
        subtitleLabel.text = "Basic Button"
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        navigationItem.titleView = subtitleLabel
        
        navigationController?.navigationBar.largeContentTitle = subtitleLabel.text
        navigationItem.title = subtitleLabel.text
        
        
        // Toolbar Items
        let customizeButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(customizeTapped))
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(infoTapped))
        navigationItem.rightBarButtonItems = [infoButton, customizeButton]
    }
    
    private func setupPageViewController() throws {
        
        // Setup  UIPageViewController
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        guard let pageVC = pageViewController else {
            throw ViewControllerError.failedLoadingView(viewController: pageViewController.debugDescription)
        }
        
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)

        // Set up constraints
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Load pages
        if let firstPage = pages.first {
            pageVC.setViewControllers([firstPage], direction: .forward, animated: true)
        } else {
            throw ViewControllerError.failedLoadingPage(message: "No pages available", page: "Unknown")
        }
        
        pageVC.dataSource = self
        pageVC.delegate = self
        
        // Setup UIPageControl
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0 // Start from the first page
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        // Set up constraints for the page control
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func customizeTapped() {
        print("Customize button tapped")
    }

    @objc private func infoTapped() {
        showInfo.toggle()
    }
    
    private func presentInfoViewController() {
//        let infoVC = UIKit_Button_InfoViewController()
//        let navController = UINavigationController(rootViewController: infoVC)
//        navController.modalPresentationStyle = .pageSheet
//        present(navController, animated: true)
    }
    
    private func showErrorAlert(for error: (any Error)?) {
        
        let localizedError = error
            .flatMap { $0 as? LocalizedError }
            .map { AnyLocalizedError($0) }
        
        if let errorDescription = localizedError?.errorDescription,
            let failureReason = localizedError?.failureReason,
           let recoverySuggestion = localizedError?.recoverySuggestion
        {
            
            let message = "\(failureReason)\n\n\(recoverySuggestion)"
            
            let alert = UIAlertController(
                title: errorDescription,
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

extension UIKit_Button_DemoViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
}

extension UIKit_Button_DemoViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        // Update the page control index when the transition is complete
        if let visibleVC = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: visibleVC) {
            pageControl.currentPage = index
        }
    }
}

import SwiftUI
#Preview {
    NavigationStack {
        UIKit_Button_DemoViewControllerRepresentable()
            .navigationTitle("UIButton")
    }
}

#endif
