//
//  Contact+CoreDataClass.swift
//  ft_hangouts
//
//  Created by Zuleykha Pavlichenkova on 28.09.2023.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//
//

import Foundation
import CoreData


public class DBContact: NSManagedObject {

}

extension DBContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBContact> {
        return NSFetchRequest<DBContact>(entityName: "DBContact")
    }

    @NSManaged var contactId: UUID
    @NSManaged var firstName: String
    @NSManaged var lastName: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var userPicture: Data?
    @NSManaged var birthDate: Date?
    @NSManaged var email: String?

    static func make(with contact: Contact, context: NSManagedObjectContext) -> DBContact {
        let entity = NSEntityDescription.entity(forEntityName: "DBContact", in: context)!
        let dbContact = DBContact(entity: entity, insertInto: context)
        dbContact.contactId = contact.contactId
        dbContact.firstName = contact.firstName
        dbContact.lastName = contact.lastName
        dbContact.phoneNumber = contact.phoneNumber
        dbContact.email = contact.email
        dbContact.birthDate = contact.birthDate
        dbContact.userPicture = contact.userPicture
        
        return dbContact
    }
    func toEntity() -> Contact {
        Contact(
            contactId: contactId,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            userPicture: userPicture,
            birthDate: birthDate,
            email: email)
    }
    
}

extension DBContact : Identifiable {

}
