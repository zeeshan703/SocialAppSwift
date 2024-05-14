//
//  Error.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation

enum ErrorCodes: Int {
    
    // Network Error
    case invalidURLReqeust = 404
    
    // Custom Error
    case userCancelRequest = 1000
    case authorizationFailed = 1001
    case doLoginFirst = 1002
}

public struct ParseFailureReason {
    public let code: Int?
    public var message: String?
    public init(code: Int = 422, message: String? = nil) {
        self.code = code
        if message == nil {
            self.message = getMessage()
        } else {
            self.message = message
        }
    }
    
    func getMessage() -> String {
        var errorMessage = ""
        switch self.code {
        case ErrorCodes.invalidURLReqeust.rawValue:
            errorMessage = "Invalid URL request"
        case ErrorCodes.userCancelRequest.rawValue:
            errorMessage = "User cancel the request"
        case ErrorCodes.authorizationFailed.rawValue:
            errorMessage = "Authorization failed due to some internal error"
        case ErrorCodes.doLoginFirst.rawValue:
            errorMessage = "Please login with your apple account"
        default:
            errorMessage = "Something went wrong"
        }
        return errorMessage
    }
}

public enum AppError: Error {
    case internalFailed(reason: Error)
    case parseFailed(reason: ParseFailureReason)
}

extension ParseFailureReason: CustomStringConvertible {
    public var description: String {
        return "\(message!)"
    }
}

extension AppError: LocalizedError {
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .internalFailed(reason: let reason):
            let errorMessages = reason.localizedDescription.components(separatedBy: ":")
            if  errorMessages.count > 1 {
                return errorMessages[1]
            }
            return reason.localizedDescription
        case .parseFailed(reason: let reason):
            return "\(reason)"
        }
    }
}

