//
//  Contact.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/13/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit
import Contacts

class Contact {
    let firstName: String
    let lastName: String
    let userPicture: UIImage?
    var phoneNumber: (CNLabeledValue<CNPhoneNumber>)?
    var birthDate: String?
    var userEmail: String
    
    init(firstName: String, lastName: String, userEmail: String, userPicture: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.userEmail = userEmail
        self.userPicture = userPicture
    }
    
    static func defaultContacts() -> [Contact] {
        return [
            Contact(firstName: "Bill", lastName: "", userEmail: "email@email.com", userPicture: UIImage(systemName: "person.crop.circle.fill")),
            Contact(firstName: "Me", lastName: "Myself", userEmail: "email@mail.com", userPicture: UIImage(systemName: "person.crop.circle")),
            Contact(firstName: "Oleg", lastName: "P", userEmail: "email.e@mail.com", userPicture: nil)
        ]
    }
}

extension Contact: Equatable {
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName &&
            lhs.phoneNumber == rhs.phoneNumber
    }
}

extension Contact {
    var contactValue: CNContact {
        let contact = CNMutableContact()
        contact.givenName = firstName
        contact.familyName = lastName
        contact.emailAddresses = [CNLabeledValue(label: CNLabelWork, value: userEmail as NSString)]
        if let userPicture = userPicture {
            let imageData = userPicture.jpegData(compressionQuality: 1)
            contact.imageData = imageData
        }
        if let phoneNumberField = phoneNumber {
            contact.phoneNumbers.append(phoneNumberField)
        }
        return contact.copy() as! CNContact
    }
    
    convenience init?(contact: CNContact) {
        guard let email = contact.emailAddresses.first else { return nil }
        let firstName = contact.givenName
        let lastName = contact.familyName
        let userEmail = email.value as String
        var userPicture: UIImage?
        if let imageData = contact.imageData {
            userPicture = UIImage(data: imageData)
        }
        self.init(firstName: firstName, lastName: lastName, userEmail: userEmail, userPicture: userPicture)
        if let contactPhone = contact.phoneNumbers.first {
            phoneNumber = contactPhone
        }
    }
}
