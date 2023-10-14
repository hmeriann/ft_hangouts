//
//  UserDataValidatingError.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 14.10.2023.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import Foundation

struct ValidationError: Error {
    var errors: [UserDataValidatingError]
}

enum UserDataValidatingError: Error {
    
    case userNameIsEmpty
    case userNameIsInvalid
    case phoneIsEmpty
    case phoneIsInvalid
    case emailIsEmpty
    case emailIsInvalid
    
    var message: String {
        switch self {
        case .userNameIsEmpty:
            return "User name is empty"
        case .userNameIsInvalid:
            return "User name is invalid"
        case .phoneIsEmpty:
            return "Phone is empty"
        case .phoneIsInvalid:
            return "Phone is invalid"
        case .emailIsEmpty:
            return "Email is empty"
        case .emailIsInvalid:
            return "Email is invalid"
        }
    }
}
