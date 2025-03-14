//
//  TechnologyViewModel.swift
//  DevLab
//
//  Created by Michael Borgmann on 07/03/2025.
//

import SwiftUI

@Observable
class TechnologyViewModel {
    
    var ecosystems: [TechnologyEcosystem] = []
    var selectedEcosystem: String?
    var error: Swift.Error?
    
    var ecosystemNames: [String] {
        ecosystems.map { $0.name }
    }

    func loadTechnologies() throws {
        if let url = Bundle.main.url(forResource: "technologies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let loadedEcosystems = try decoder.decode([TechnologyEcosystem].self, from: data)
                ecosystems = loadedEcosystems
                selectedEcosystem = ecosystems.first?.name
            } catch {
                self.error = Error.failedLoadingData(message: error.localizedDescription, filename: "technologies.json")
            }
        }
    }
}

extension TechnologyViewModel {
    
    enum Error: LocalizedError {
        
        case failedLoadingData(message: String, filename: String)
        case demoNotFound(demoName: String)
        
        var errorDescription: String? {
            switch self {
            case .failedLoadingData:
                "Failed Loading Data"
            case .demoNotFound:
                "Demo Not Found"
            }
        }
        
        var failureReason: String? {
            switch self {
            case .failedLoadingData(let error, let filename):
                "The application could not read data from `\(filename)`: \(error)"
            case .demoNotFound(let demoName):
               "The demo view for `\(demoName)` was not found in the app."
           }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .failedLoadingData:
                "Please check the file's existence and format, or contact support if the issue persists."
            case .demoNotFound:
                "Make sure the demo is properly implemented and the name matches the one in the data."
            }
        }
    }
}
