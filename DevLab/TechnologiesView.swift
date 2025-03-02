//
//  TechnologiesView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/03/2025.
//

import SwiftUI

struct Technology {
    let id = UUID()
    let name: String
    let demos: [String]
}

struct TechnologyCard: View {
    let title: String
    let background: AnyView // Allows flexibility for colors, gradients, and images

    var body: some View {
        Text(title)
            .foregroundStyle(.white)
            .font(.title2)
            .bold()
            .frame(width: 200, height: 120)
            .background(
                background
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            )
            .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
            .padding(.vertical, 5)
    }
}

struct TechnologyDetailView: View {
    
    let title: String
    let technology: String
    
    var body: some View {
        VStack {
            Text(technology)
                .font(.largeTitle)
                .bold()
                .padding()

            Spacer()
        }
        .navigationTitle(title)
    }
}

enum TechnologyType: String, CaseIterable {
    
    case apple = "Apple"
    case thirdParty = "3rd Party"
    case web = "Web"
    
    var icon: String {
        switch self {
            
        case .apple:
            "applelogo"
        case .thirdParty:
            "square.and.arrow.up.on.square.fill"
        case .web:
            "app.badge.checkmark"
        }
    }
    
    var technologyDemos: [Technology] {
        switch self {
            
        case .apple:
            return [
                Technology(name: "Swift", demos: ["Intro", "Advanced Concepts", "Async/Await", "Error Handling"]),
                Technology(name: "SwiftUI", demos: ["Views", "Navigation", "Animation", "Gestures", "Bindings"]),
                Technology(name: "UIKit", demos: ["UI Elements", "Navigation", "AutoLayout"]),
                Technology(name: "CoreData", demos: ["Fetching", "Saving", "Relationships"]),
                Technology(name: "Combine", demos: ["Publishers", "Subscribers", "Operators"]),
                Technology(name: "CloudKit", demos: ["Syncing", "Authentication"]),
                Technology(name: "SwiftData", demos: ["Persistence", "Models"])
            ]
        case .thirdParty:
            return [
                Technology(name: "AudioKit", demos: ["Synthesizers", "Effects", "Recording"]),
                Technology(name: "Realm", demos: ["CRUD Operations", "Schema Migration"]),
                Technology(name: "RxSwift", demos: ["Observables", "Schedulers"])
            ]
        case .web:
            return [
                Technology(name: "React", demos: ["Components", "Hooks", "State Management"]),
                Technology(name: "Vue.js", demos: ["Directives", "Vuex"]),
                Technology(name: "Angular", demos: ["Modules", "Dependency Injection"]),
                Technology(name: "Flutter", demos: ["Widgets", "State Management"])
            ]
        }
    }
}

struct TechnologiesView: View {
    
    @State private var selectedCategory: TechnologyType = .apple
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                selectCategory
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        ForEach(selectedCategory.technologyDemos, id: \.name) { technology in
                            
                            VStack(alignment: .leading) {
                                
                                
                                Text(technology.name)
                                    .font(.headline)
                                    .padding(.top, 10)
                                    .padding(.leading, 16)
                                
                                horizontalScroller(for: technology)
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
                .navigationTitle("Technologies")
            }
        }
    }
    
    // UI components
    
    private var selectCategory: some View {
        Picker("Select a Category", selection: $selectedCategory) {
            ForEach(TechnologyType.allCases, id: \.self) { category in
                Text(category.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private func horizontalScroller(for technology: Technology) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                
                Spacer().frame(width: 0)
                
                ForEach(technology.demos, id: \.self) { demo in
                    
                    NavigationLink(destination: TechnologyDetailView(title: technology.name, technology: demo) ) {
                        
                        TechnologyCard(
                            title: demo,
                            background: AnyView(
                                LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        )
                    }
                }
                
                Spacer().frame(width: 0)
            }
        }
    }
}

#Preview {
    TechnologiesView()
}
