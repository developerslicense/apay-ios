//
//  MoneyTests.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import XCTest
@testable import ApayIOS

final class GetNumberClearedTests: XCTestCase {//todo

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func testGetNumberCleared(
            amount: String?,
            isUserEntered: Bool = false
    ) -> String {
        getNumberCleared(
                amount: amount,
                isUserEntered: isUserEntered
        )
    }

    func testsGetNumberCleared() throws {

        XCTAssertEqual(testGetNumberCleared(amount: "±§!@#$&*:[]`~%^&100000.0"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^.0"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^,0"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^.00"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^,00"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000&*()^00"),  "100000")

        XCTAssertEqual(
                testGetNumberCleared(amount: "±§!@#$&*:[]`~%^&1000000", isUserEntered: true),
                 "1000000"
        )
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^.0", isUserEntered: true),  "1000000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^,0", isUserEntered: true),  "1000000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^.00", isUserEntered: true),  "10000000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^,00", isUserEntered: true),  "10000000")
        XCTAssertEqual(testGetNumberCleared(amount: "100000&*()^", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000&*()^00", isUserEntered: true),  "100000")

        XCTAssertEqual(testGetNumberCleared(amount: " 1 234 567 890 ${kzt}", isUserEntered: true),  "1234567890")
        XCTAssertEqual(
                testGetNumberCleared(amount: " 1 234 567 890 ${kzt}", isUserEntered: false),
                 "1234567890"
        )

        testWithMinus()
    }

    private func testWithMinus() {
        XCTAssertEqual(testGetNumberCleared(amount: "-100000"),  "-100000")
        XCTAssertEqual(testGetNumberCleared(amount: "--100000"),  "-100000")
        XCTAssertEqual(testGetNumberCleared(amount: "--100-000"),  "-100000")
        XCTAssertEqual(testGetNumberCleared(amount: "-100000.0"),  "-100000")
        XCTAssertEqual(testGetNumberCleared(amount: "-1000zXьЛ00"),  "-100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1-000zXьЛ00"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000-zXьЛ00"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ-00"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ00-"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ00.-"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ00.-0"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ00.-00"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ00.-0-0"),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "-1000zXьЛ00.-0-0"),  "-100000")

        XCTAssertEqual(testGetNumberCleared(amount: "-100000", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "--100000", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "--100-000", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "-100000.0", isUserEntered: true),  "1000000")
        XCTAssertEqual(testGetNumberCleared(amount: "-1000zXьЛ00", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1-000zXьЛ00", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000-zXьЛ00", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ-00", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ00-", isUserEntered: true),  "100000")
        XCTAssertEqual(testGetNumberCleared(amount: "1000zXьЛ00.-", isUserEntered: true),  "100000")
        XCTAssertEqual(
                testGetNumberCleared(amount: "1000zXьЛ00.-0", isUserEntered: true),
                 "1000000"
        )
        XCTAssertEqual(
                testGetNumberCleared(amount: "1000zXьЛ00.-00", isUserEntered: true),
                 "10000000"
        )
        XCTAssertEqual(
                testGetNumberCleared(amount: "1000zXьЛ00.-0-0", isUserEntered: true),
                 "10000000"
        )
        XCTAssertEqual(
                testGetNumberCleared(amount: "-1000zXьЛ00.-0-0", isUserEntered: true),
                 "10000000"
        )

    }
    
}
