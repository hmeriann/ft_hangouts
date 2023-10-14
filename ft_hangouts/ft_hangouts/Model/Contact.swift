//
//  Contact.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 14.10.2023.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import Foundation

struct Contact {
    let contactId: UUID
    let firstName: String
    let lastName: String?
    let phoneNumber: String?
    let userPicture: Data?
    let birthDate: Date?
    let email: String?
    
}

extension Contact {
    init(with dbContact: DBContact) {
        self.contactId = dbContact.contactId
        self.firstName = dbContact.firstName
        self.lastName = dbContact.lastName
        self.phoneNumber = dbContact.phoneNumber
        self.userPicture = dbContact.userPicture
        self.birthDate = dbContact.birthDate
        self.email = dbContact.email
    }
}
