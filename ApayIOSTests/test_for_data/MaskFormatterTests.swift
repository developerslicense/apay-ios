//
//  MoneyTests.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import XCTest
@testable import ApayIOS

final class MaskFormatterTests: XCTestCase {

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

        XCTAssertEqual(initMaskFormatterAndFormat(pattern: "XXXXXAAAA", text: "S1234567B"), "XXXXXS123")
        XCTAssertEqual(
                initMaskFormatterAndFormat(pattern: "+7 (AAA) AAA AA AA", text: "7051234567"),
                "+7 (705) 123 45 67"
        )
        XCTAssertEqual(
                initMaskFormatterAndFormat(pattern: "+7 (AAA) AAA AA AA", text: "7051234567"),
                "+7 (705) 123 45 67"
        )
        XCTAssertEqual(
                initMaskFormatterAndFormat(pattern: "+7 (AAA)-AAA-AA-AA", text: "7051234567"),
                "+7 (705)-123-45-67"
        )
        XCTAssertEqual(
                initMaskFormatterAndFormat(pattern: "AAAA*AAAA*AAAA*AAAA", text: "1234567890123456"),
                "1234*5678*9012*3456"
        )
        XCTAssertEqual(
                initMaskFormatterAndFormat(pattern: "AAAA AAAA AAAA AAAA", text: "1234567890123456"),
                "1234 5678 9012 3456"
        )

        XCTAssertEqual(initNewCursorPosition(newPosition: 0), 0)
        XCTAssertEqual(initNewCursorPosition(newPosition: 1),  1)
        XCTAssertEqual(initNewCursorPosition(newPosition: 2),  2)

        XCTAssertEqual(initNewCursorPosition(newPosition: 3),  3)
        XCTAssertEqual(initNewCursorPosition(newPosition: 4),  5)

        XCTAssertEqual(initNewCursorPosition(newPosition: 5),  5)
        XCTAssertEqual(initNewCursorPosition(newPosition: 6),  6)
        XCTAssertEqual(initNewCursorPosition(newPosition: 7),  7)
        XCTAssertEqual(initNewCursorPosition(newPosition: 8),  8)

        XCTAssertEqual(initNewCursorPosition(newPosition: 9),  10)
        XCTAssertEqual(initNewCursorPosition(newPosition: 10),  10)
        XCTAssertEqual(initNewCursorPosition(newPosition: 11),  11)
        XCTAssertEqual(initNewCursorPosition(newPosition: 12),  12)
        XCTAssertEqual(initNewCursorPosition(newPosition: 13),  13)

        XCTAssertEqual(initNewCursorPosition(newPosition: 14),  15)
    }


    private func testPhone(text: String) {
        let maskFormatterPhone = initMaskFormatter(pattern: "+7 (AAA)-AAA-AA-AA")

        let cleared = getNumberCleared(amount: text, isPhoneNumber: true)
        let phone = maskFormatterPhone.format(text: cleared, optionForTest: true)

        XCTAssertEqual(phone, "+7 (705)-123-45-67")
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

}
