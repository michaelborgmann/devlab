//
//  SettingsViewModel.swift
//  DevLab
//
//  Created by Michael Borgmann on 13/03/2025.
//

import SwiftUI

@Observable
class SettingsViewModel {
    var error: Swift.Error?
}

extension SettingsViewModel {
    
    enum Error: LocalizedError {
        
        case fileNotFound(filename: String)
        case loadingFailure(filename: String)
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                "File Not Found"
            case .loadingFailure:
                "Loading Failure"
            }
        }
        
        var failureReason: String? {
            switch self {
            case .fileNotFound(let filename):
                "File `\(filename)` not found."
            case .loadingFailure(let filename):
                "Failed to load document information from `\(filename).`"
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .fileNotFound:
                "Make sure file exists and the correct filename is used."
            case .loadingFailure:
                "Check the document format or the content of the file."
            }
        }
    }
}
