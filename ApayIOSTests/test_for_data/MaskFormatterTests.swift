//
//  MoneyTests.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import XCTest
@testable import ApayIOS

final class MaskFormatterTests: XCTestCase {//todo

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMaskFormatter() throws {

        testPhone(text: "+7 (705) 123-45-67")
        testPhone(text: "8 (705) 123-45-67")
        testPhone(text: "+7(705)123-45-67")
        testPhone(text: "+7705123-45-67")
        testPhone(text: "+77051234567")
        testPhone(text: "7 (705) 123-45-67")

        testPhone(text: "7051234567")
        testPhone(text: "+ (705) 123-45-67")

        isAssert(actual: initMaskFormatterAndFormat(pattern: "XXXXXAAAA", text: "S1234567B"), expected: "XXXXXS123")
        isAssert(
                actual: initMaskFormatterAndFormat(pattern: "+7 (AAA) AAA AA AA", text: "7051234567"),
                expected: "+7 (705) 123 45 67"
        )
        isAssert(
                actual: initMaskFormatterAndFormat(pattern: "+7 (AAA) AAA AA AA", text: "7051234567"),
                expected: "+7 (705) 123 45 67"
        )
        isAssert(
                actual: initMaskFormatterAndFormat(pattern: "+7 (AAA)-AAA-AA-AA", text: "7051234567"),
                expected: "+7 (705)-123-45-67"
        )
        isAssert(
                actual: initMaskFormatterAndFormat(pattern: "AAAA*AAAA*AAAA*AAAA", text: "1234567890123456"),
                expected: "1234*5678*9012*3456"
        )
        isAssert(
                actual: initMaskFormatterAndFormat(pattern: "AAAA AAAA AAAA AAAA", text: "1234567890123456"),
                expected: "1234 5678 9012 3456"
        )

        isAssert(actual: initNewCursorPosition(newPosition: 0), expected: 0)

        isAssert(actual: initNewCursorPosition(newPosition: 1),  expected: 1)
        isAssert(actual: initNewCursorPosition(newPosition: 2),  expected: 2)
        isAssert(actual: initNewCursorPosition(newPosition: 3),  expected: 3)
        isAssert(actual: initNewCursorPosition(newPosition: 4),  expected: 5)

        isAssert(actual: initNewCursorPosition(newPosition: 5),  expected: 5)
        isAssert(actual: initNewCursorPosition(newPosition: 6),  expected: 6)
        isAssert(actual: initNewCursorPosition(newPosition: 7),  expected: 7)
        isAssert(actual: initNewCursorPosition(newPosition: 8),  expected: 8)

        isAssert(actual: initNewCursorPosition(newPosition: 9),  expected: 10)
        isAssert(actual: initNewCursorPosition(newPosition: 10), expected:  10)
        isAssert(actual: initNewCursorPosition(newPosition: 11), expected:  11)
        isAssert(actual: initNewCursorPosition(newPosition: 12), expected:  12)
        isAssert(actual: initNewCursorPosition(newPosition: 13), expected:  13)

        isAssert(actual: initNewCursorPosition(newPosition: 14), expected:  15)
    }

    private func testPhone(text: String) {
        let maskFormatterPhone = initMaskFormatter(pattern: "+7 (AAA)-AAA-AA-AA")

        let cleared = getNumberCleared(amount: text, isPhoneNumber: true)
        let phone = maskFormatterPhone.format(text: cleared, optionForTest: true)

        isAssert(actual: phone, expected: "+7 (705)-123-45-67")
    }

    private func initMaskFormatterAndFormat(
            pattern: String,
            text: String
    ) -> String {
        initMaskFormatter(pattern: pattern).format(text: text, optionForTest: true)
    }


    private func initMaskFormatter(pattern: String
    ) -> MaskUtils {
        let temp = MaskUtils()
        temp.pattern = pattern
        return temp
    }

    private func initNewCursorPosition(
            newPosition: Int,
            mask: String = "AAAA AAAA AAAA AAAA"
    ) -> Int {
        let maskUtils = MaskUtils()
        maskUtils.pattern = mask
        return maskUtils.getNextCursorPosition(newPosition: newPosition)
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
