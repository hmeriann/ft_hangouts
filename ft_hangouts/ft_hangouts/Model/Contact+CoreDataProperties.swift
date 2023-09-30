//
//  Contact+CoreDataProperties.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 28.09.2023.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged var contactId: UUID
    @NSManaged var firstName: String
    @NSManaged var lastName: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var userPicture: Data?
    @NSManaged var birthDate: Date?
    @NSManaged var email: String?

}

extension Contact : Identifiable {

}
