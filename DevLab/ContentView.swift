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
            
            TechnologiesView()
                .tabItem {
                    Label("Technologies", systemImage: "wrench.and.screwdriver")
                }
            
            DemosView()
                .tabItem {
                    Label("Demos", systemImage: "flask")
                }
            
            PracticesView()
                .tabItem {
                    Label("Practices", systemImage: "book.closed")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

// Placeholder Views
struct HomeView: View {
    
    var body: some View {
        NavigationView {
            Text("🏠 Home - Featured, Recent, Popular Demos")
                .navigationTitle("Home")
        }
    }
}

struct DemosView: View {
    var body: some View {
        NavigationView {
            Text("🧪 Browse by Use Case (Networking, Animations, etc.)")
                .navigationTitle("Demos")
        }
    }
}

struct PracticesView: View {
    var body: some View {
        NavigationView {
            Text("📚 Best Practices & Design Patterns")
                .navigationTitle("Practices")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Text("⚙️ Feature Flags & Preferences")
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    ContentView()
}
