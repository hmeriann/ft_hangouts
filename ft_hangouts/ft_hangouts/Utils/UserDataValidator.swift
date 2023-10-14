//
//  EmailValidator.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 14.10.2023.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import Foundation

enum Patterns {
    case emailValidating
    case phoneValidating
    
    var pattern: String {
        switch self {
        case .emailValidating:
            return #"^\S+@\S+\.\S+$"#
        case .phoneValidating:
            return #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
        }
    }
}

protocol UserDataValidating {
    func validate(email: String) -> Bool
    func validate(phone: String) -> Bool
}

final class UserDataValidator: UserDataValidating {
    
    func validate(email: String) -> Bool {
        return validate(value: email, pattern: Patterns.emailValidating.pattern)
    }
    
    func validate(phone: String) -> Bool {
        return validate(value: phone, pattern: Patterns.phoneValidating.pattern)
    }
    
    private func validate(value: String, pattern: String) -> Bool {
        let result = value.range(
            of: pattern,
            options: .regularExpression
        )
        return result != nil
    }

}
