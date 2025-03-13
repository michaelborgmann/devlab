//
//  ContentView.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/02/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .accessibilityLabel("Home Tab")
                .accessibilityHint("View featured, recent, and popular demos.")
            
            TechnologiesView()
                .tabItem {
                    Label("Technologies", systemImage: "wrench.and.screwdriver")
                }
                .accessibilityLabel("Technologies Tab")
                .accessibilityHint("Explore tech demos and technologies.")
            
            DemosView()
                .tabItem {
                    Label("Demos", systemImage: "flask")
                }
                .accessibilityLabel("Demos Tab")
                .accessibilityHint("Browse demos based on use cases.")
            
            PracticesView()
                .tabItem {
                    Label("Practices", systemImage: "book.closed")
                }
                .accessibilityLabel("Practices Tab")
                .accessibilityHint("Learn about best practices and design patterns.")
            
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .accessibilityLabel("Settings Tab")
                .accessibilityHint("Configure preferences and feature flags.")
        }
        .accessibilityElement(children: .ignore)
    }
}

// Placeholder Views

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            Text("🏠 Home - Featured, Recent, Popular Demos")
                .navigationTitle("Home")
                .accessibilityLabel("Featured, recent, and popular demos.")
                .accessibilityHint("Tap to view the latest demos.")
        }
    }
}

struct DemosView: View {
    var body: some View {
        NavigationStack {
            Text("🧪 Browse by Use Case (Networking, Animations, etc.)")
                .navigationTitle("Demos")
                .accessibilityLabel("Browse demos by use case.")
                .accessibilityHint("Tap to explore use cases like networking or animations.")
        }
    }
}

struct PracticesView: View {
    var body: some View {
        NavigationStack {
            Text("📚 Best Practices & Design Patterns")
                .navigationTitle("Practices")
                .accessibilityLabel("Learn about best practices and design patterns.")
                .accessibilityHint("Tap to view helpful coding practices and patterns.")
        }
    }
}

#Preview {
    ContentView()
}
