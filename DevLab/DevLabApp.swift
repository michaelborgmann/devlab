//
//  DevLabApp.swift
//  DevLab
//
//  Created by Michael Borgmann on 27/02/2025.
//

import SwiftUI

@main
struct DevLabApp: App {
    
    @AppStorage("appTheme") private var isDarkModeOn = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
