//
//  Contact.swift
//  ft_hangouts
//
//  Created by Heidi Merianne on 9/13/23.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import UIKit

class Contact {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let userPicture: UIImage?
    var birthDate: String?
    var email: String?
    
    init(firstName: String, lastName: String, phoneNumber: String, userPicture: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.userPicture = userPicture
    }
    
    static func defaultContacts() -> [Contact] {
        return [
            Contact(firstName: "Bill", lastName: "", phoneNumber: "+3106064365", userPicture: UIImage(systemName: "person.crop.circle.fill")),
            Contact(firstName: "Me", lastName: "Myself", phoneNumber: "+3127277451", userPicture: UIImage(systemName: "person.crop.circle")),
            Contact(firstName: "Oleg", lastName: "P", phoneNumber: "+3127277478", userPicture: nil)
        ]
    }
}
