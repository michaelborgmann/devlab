//
//  ButtonDemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/03/2025.
//

import SwiftUI

struct ButtonDemoView: View {
    @State private var labelText = "Tap the button!"
    
    var body: some View {
        VStack {
            Text(labelText)
                .font(.title)
                .padding()
            
            Button("Change Text") {
                labelText = "You tapped the button!"
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct ButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDemoView()
    }
}
