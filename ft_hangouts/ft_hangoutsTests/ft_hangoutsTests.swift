//
//  ft_hangoutsTests.swift
//  ft_hangoutsTests
//
//  Created by Zuleykha Pavlichenkova on 14.10.2023.
//  Copyright © 2023 Zuleykha Pavlichenkova. All rights reserved.
//

import XCTest
@testable import ft_hangouts

final class EmailValidatorTest: XCTestCase {

    let validator = UserDataValidator()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_validateValidUserNameReturnsTrue() throws {
        let userNameToTest = "OOOaaa"
        
        let result = validator.validate(userName: userNameToTest)
        XCTAssertTrue(result)
    }
    
    func test_validateEmptyUserNameReturnsFalse() throws {
        let userNameToTest = ""
        
        let result = validator.validate(userName: userNameToTest)
        XCTAssertFalse(result)
    }
    
    func test_validateInvalidUserNameReturnsFalse() throws {
        let userNameToTest = "%%%02233"
        
        let result = validator.validate(userName: userNameToTest)
        XCTAssertFalse(result)
    }

    func test_validateValidEmailReturnsTrue() throws {
        let emailToTest = "mail@mail.com"
        
        let result = validator.validate(email: emailToTest)
        XCTAssertTrue(result)
    }
    
    func test_validateInvalidEmailReturnsFalse() throws {
        let emailToTest = "mailom"
        
        let result = validator.validate(email: emailToTest)
        XCTAssertFalse(result)
    }
    
    func test_validateEmptyEmailReturnsFalse() throws {
        let emailToTest = ""
        
        let result = validator.validate(email: emailToTest)
        XCTAssertFalse(result)
    }
    
    func test_validateValidPhoneReturnsTrue() throws {
        let phoneToTest = "+310627277451"
        
        let result = validator.validate(phone: phoneToTest)
        XCTAssertTrue(result)
    }
    
    func test_validateEmptyPhoneReturnsFalse() throws {
        let phoneToTest = ""
        
        let result = validator.validate(phone: phoneToTest)
        XCTAssertFalse(result)
    }
    
    func test_validateInvalidPhoneReturnsFalse() throws {
        let phoneToTest = "dssafa"
        
        let result = validator.validate(phone: phoneToTest)
        XCTAssertFalse(result)
    }
}
