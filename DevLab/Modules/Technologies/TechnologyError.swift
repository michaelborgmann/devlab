//
//  TechnologyError.swift
//  DevLab
//
//  Created by Michael Borgmann on 09/03/2025.
//

import Foundation

struct AnyLocalizedError: LocalizedError {
    
    private let error: LocalizedError
    
    var errorDescription: String? {
        error.errorDescription
    }
    
    var failureReason: String? {
        error.failureReason
    }
    
    var recoverySuggestion: String? {
        error.recoverySuggestion
    }
    
    init(_ error: LocalizedError) {
        self.error = error
    }
}
