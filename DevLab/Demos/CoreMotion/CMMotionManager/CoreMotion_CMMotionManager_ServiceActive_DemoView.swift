//
//  CoreMotion_CMMotionManager_ServiceActive_DemoView.swift
//  DevLab
//
//  Created by Michael Borgmann on 02/02/2026.
//

import SwiftUI
import CoreMotion

struct CoreMotion_CMMotionManager_ServiceActive_DemoView: DemoPage {
    
    @State private var motion = CMMotionManager()
    @State private var isEnabled = false
    
    // Keep a stable queue
    private let queue: OperationQueue = {
        let q = OperationQueue()
        q.qualityOfService = .userInitiated
        return q
    }()
    
    @Binding var viewModel: DemoViewModel
    let id: UUID
    
    @State private var isDeviceMotionActive = false
    @State private var isAccelerometerActive = false
    @State private var isGyroActive = false
    @State private var isMagnetometerActive = false
    
    var body: some View {
        VStack {
            Text("A demo to check which CoreMotion services are active.")
            
            Spacer()
            
            Toggle("Enable Services", isOn: $isEnabled)
            
            List {
                row("Device Motion", isDeviceMotionActive)
                row("Accelerometer", isAccelerometerActive)
                row("Gyro", isGyroActive)
                row("Magnetometer", isMagnetometerActive)
            }
            
            Spacer()
        }
        .onAppear {
            viewModel.subtitle = "Determining Which Services Are Active"
        }
        .onChange(of: isEnabled) { _, isEnabled in
            isEnabled ? start() : stop()
        }
    }
    
    // MARK: Helper
    
    private func start() {
        
        motion.startDeviceMotionUpdates(to: queue) { _, _ in
            isDeviceMotionActive = motion.isDeviceMotionActive
        }
        
        motion.startAccelerometerUpdates(to: queue) { _, _ in
            isAccelerometerActive = motion.isAccelerometerActive
        }
        
        motion.startGyroUpdates(to: queue) { _, _ in
            isGyroActive = motion.isGyroActive
        }
        
        motion.startMagnetometerUpdates(to: queue) { _, _ in
            isMagnetometerActive = motion.isMagnetometerActive
        }
    }
    
    private func stop() {
        motion.stopDeviceMotionUpdates()
        motion.stopAccelerometerUpdates()
        motion.stopGyroUpdates()
        motion.stopMagnetometerUpdates()
        
        isDeviceMotionActive = motion.isDeviceMotionActive
        isAccelerometerActive = motion.isAccelerometerActive
        isGyroActive = motion.isGyroActive
        isMagnetometerActive = motion.isMagnetometerActive
    }
    
    // MARK: Subviews
    
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
        CoreMotion_CMMotionManager_ServiceActive_DemoView(viewModel: $viewModel)
    }
}
