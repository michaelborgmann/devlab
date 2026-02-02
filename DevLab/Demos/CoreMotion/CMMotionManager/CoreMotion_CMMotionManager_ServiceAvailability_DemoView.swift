//
//  CoreMotion_CMMotionManager_Basic_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/02/2026.
//

import SwiftUI
import CoreMotion

struct CoreMotion_CMMotionManager_ServiceAvailability_DemoView: DemoPage {
    
    private let motion = CMMotionManager()
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    var body: some View {
        VStack {
            Text("A demo to check the availability of CoreMotion service.")
            
            Spacer()
            
            List {
                row("Device Motion", motion.isDeviceMotionAvailable)
                row("Accelerometer", motion.isAccelerometerAvailable)
                row("Gyro", motion.isGyroAvailable)
                row("Magnetometer", motion.isMagnetometerAvailable)
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.subtitle = "Determining the Availability of Services"
        }
    }
    
    private func row(_ title: String, _ value: Bool) -> some View {
        HStack {
            Text(title).bold()
            Spacer()
            Text("\(value ? "✅": "❌")")
        }
    }
}

#Preview {
    
    @Previewable @State var viewModel = DemoViewModel()
    
    VStack {
        CoreMotion_CMMotionManager_ServiceAvailability_DemoView(viewModel: $viewModel)
    }
}
