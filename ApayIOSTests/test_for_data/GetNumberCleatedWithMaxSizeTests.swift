//
//  MoneyTests.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import XCTest
@testable import ApayIOS

final class GetNumberClearedWithMaxSizeTests: XCTestCase {

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
        getNumberClearedWithMaxSymbol(amount: amount, isUserEntered: isUserEntered)
    }

    func testsGetNumberClearedWithMaxSize() throws {
        isAssert(actual: testGetNumberCleared(amount: "±§!@#$&*:[]`~%^&100000.0"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^.0"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^,0"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^.00"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^,00"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000&*()^00"), expected: "100000")

        isAssert(actual: testGetNumberCleared(amount: "±§!@#$&*:[]`~%^&100000.0", isUserEntered: true), expected: "1000000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^.0", isUserEntered: true), expected: "1000000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^,0", isUserEntered: true), expected: "1000000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^.00", isUserEntered: true), expected: "10000000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^,00", isUserEntered: true), expected: "10000000")
        isAssert(actual: testGetNumberCleared(amount: "100000&*()^", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000&*()^00", isUserEntered: true), expected: "100000")

        isAssert(actual: testGetNumberCleared(amount: " 1 234 567 890 ${kzt}", isUserEntered: true), expected: "1234567890")
        isAssert(actual: testGetNumberCleared(amount: " 1 234 567 890 ${kzt}", isUserEntered: false), expected: "1234567890")

        testWithMinus()

    }


    private func testWithMinus() {
        isAssert(actual: testGetNumberCleared(amount: "-100000"), expected: "-100000")
        isAssert(actual: testGetNumberCleared(amount: "--100000"), expected: "-100000")
        isAssert(actual: testGetNumberCleared(amount: "--100-000"), expected: "-100000")
        isAssert(actual: testGetNumberCleared(amount: "-100000.0"), expected: "-100000")
        isAssert(actual: testGetNumberCleared(amount: "-1000zXьЛ00"), expected: "-100000")
        isAssert(actual: testGetNumberCleared(amount: "1-000zXьЛ00"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000-zXьЛ00"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ-00"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00-"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-0"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-00"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-0-0"), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "-1000zXьЛ00.-0-0"), expected: "-100000")

        isAssert(actual: testGetNumberCleared(amount: "-100000", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "--100000", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "--100-000", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "-100000.0", isUserEntered: true), expected: "1000000")
        isAssert(actual: testGetNumberCleared(amount: "-1000zXьЛ00", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1-000zXьЛ00", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000-zXьЛ00", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ-00", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00-", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-", isUserEntered: true), expected: "100000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-0", isUserEntered: true), expected: "1000000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-00", isUserEntered: true), expected: "10000000")
        isAssert(actual: testGetNumberCleared(amount: "1000zXьЛ00.-0-0", isUserEntered: true), expected: "10000000")
        isAssert(actual: testGetNumberCleared(amount: "-1000zXьЛ00.-0-0", isUserEntered: true), expected: "10000000")

    }

    private func isAssert(
            actual: String?,
            expected: String
    ) {
        XCTAssertEqual(actual, expected)
    }

    private func isAssert(
            actual: Double?,
            expected: String
    ) {
        XCTAssertEqual(String(actual ?? 0), expected)
    }

    private func isAssert(
            actual: Int?,
            expected: String
    ) {
        XCTAssertEqual(String(actual ?? 0), expected)
    }

    private func isAssert(
            actual: Int?,
            expected: Int
    ) {
        XCTAssertEqual(actual ?? 0, expected)
    }

    private func isAssert(
            actual: Bool,
            expected: Bool
    ) {
        XCTAssertEqual(actual, expected)
    }

}
