//
//  MoneyTests.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 14.08.2023.
//

import XCTest
@testable import ApayIOS

final class MoneyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testInitMoney() throws {

        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: 0)), expected: 0)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: 123)), expected: 123)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: "012")), expected: 12)
        isAssert(actual: String(initMoneyAmountMoney(amounts: initMoney(amount: "012"))), expected: "12")
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: "0012")), expected: 12)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: "000012")), expected: 12)
        isAssert(actual: String(initMoneyAmountMoney(amounts: initMoney(amount: "000012"))), expected: "12")
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: "0000120")), expected: 120)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: "00001020")), expected: 1020)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: 5123)), expected: 5123)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: 123456)), expected: 123456)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: 1234567890)), expected: 1234567890)
        isAssert(actual: initMoneyAmountMoney(amounts: initMoney(amount: "12345678901234")), expected: 1234567890)

        isAssert(actual: initMoneyAmountInt(amount: 0), expected: 0)
        isAssert(actual: initMoneyAmountInt(amount: 123), expected: 123)
//        isAssert(initMoneyAmountLong("012"), 12)
//        isAssert(initMoneyAmountLong("00012"), 12)
//        isAssert(initMoneyAmountLong("0000012"), 12)
        isAssert(actual: initMoneyAmountInt(amount: 5123), expected: 5123)
        isAssert(actual: initMoneyAmountInt(amount: 123456), expected: 123456)
        isAssert(actual: initMoneyAmountInt(amount: 1234567890), expected: 1234567890)
        isAssert(actual: initMoneyAmountInt(amount: 12345678901234), expected: 1234567890)

        isAssert(actual: initMoneyAmountDouble(amounts: 0.0), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 123.0), expected: 123)
        isAssert(actual: initMoneyAmountDouble(amounts: 0.0), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 00.0), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 0000.0), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 0.12), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 00.12), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 0000.12), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 0000.1200), expected: 0)
        isAssert(actual: initMoneyAmountDouble(amounts: 5.123), expected: 5)
        isAssert(actual: initMoneyAmountDouble(amounts: 6.1234), expected: 6)
        isAssert(actual: initMoneyAmountDouble(amounts: 123456.1234), expected: 123456)
        isAssert(actual: initMoneyAmountDouble(amounts: 12345678.1234), expected: 12345678)
        isAssert(actual: initMoneyAmountDouble(amounts: 1234567890.1234), expected: 1234567890)


        isAssert(actual: initMoneyAmountString(amounts: "0"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "123"), expected: 123)
        isAssert(actual: initMoneyAmountString(amounts: "012"), expected: 12)
        isAssert(actual: String(initMoneyAmountString(amounts: "012")), expected: "12")
        isAssert(actual: String(initMoneyAmountString(amounts: "000012")), expected: "12")
        isAssert(actual: String(initMoneyAmountString(amounts: "0040012")), expected: "40012")
        isAssert(actual: initMoneyAmountString(amounts: "5123"), expected: 5123)
        isAssert(actual: initMoneyAmountString(amounts: "123456"), expected: 123456)
        isAssert(actual: initMoneyAmountString(amounts: "1234567890"), expected: 1234567890)
        isAssert(actual: initMoneyAmountString(amounts: "12345678901234"), expected: 1234567890)
        isAssert(actual: initMoneyAmountString(amounts: "0"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "123.0"), expected: 123)
        isAssert(actual: initMoneyAmountString(amounts: "0.0"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "0.12"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "5.123"), expected: 5)
        isAssert(actual: initMoneyAmountString(amounts: "6.1234"), expected: 6)
        isAssert(actual: initMoneyAmountString(amounts: "123456.1234"), expected: 123456)
        isAssert(actual: initMoneyAmountString(amounts: "12345678.1234"), expected: 12345678)
        isAssert(actual: initMoneyAmountString(amounts: "1234567890.1234"), expected: 1234567890)
        isAssert(actual: initMoneyAmountString(amounts: "0ds&#$ %!"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!1ds&#$ %!23ds&#$ %!"), expected: 123)
        isAssert(actual: initMoneyAmountString(amounts: "0ds&#$ %!12ds&#$ %!"), expected: 12)
        isAssert(actual: String(initMoneyAmountString(amounts: "012ds&#$ %!")), expected: "12")
        isAssert(actual: String(initMoneyAmountString(amounts: "0000ds&#$ %!12")), expected: "12")
        isAssert(actual: String(initMoneyAmountString(amounts: "004ds&#$ %!0012")),  expected:"40012")
        isAssert(actual: initMoneyAmountString(amounts: "5ds&#$ %!123"), expected: 5123)
        isAssert(actual: initMoneyAmountString(amounts: "123456vds&#$ %!"), expected: 123456)
        isAssert(actual: initMoneyAmountString(amounts: "1ds&#$ %!234567890"), expected: 1234567890)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!12345678ds&#$ %!901234"), expected: 1234567890)
        isAssert(actual: initMoneyAmountString(amounts: "0"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "1ds&#$ %!23.0"), expected: 123)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!0.0ds&#$ %!"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!0.12"), expected: 0)
        isAssert(actual: initMoneyAmountString(amounts: "5.12ds&#$ %!3"), expected: 5)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!6.1234"), expected: 6)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!12ds&#$ %!3456.1234"), expected: 123456)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!1234567ds&#$ %!8.1234"), expected: 12345678)
        isAssert(actual: initMoneyAmountString(amounts: "ds&#$ %!12345678ds&#$ %!90.1234"), expected: 1234567890)


        isAssert(actual: _getMoneyFormatted(amount: "0"), expected: "0 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "123"), expected: "123 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "012"), expected: "12 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "012"), expected: "12 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "000012"), expected: "12 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "0040012"), expected: "40 012 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "5123"), expected: "5 123 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "123456"), expected: "123 456 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "1234567890"), expected: "1 234 567 890 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "12345678901234"), expected: "1 234 567 890 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "123.0"), expected: "123 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "0.0"), expected: "0 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "0.12"), expected: "0 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "5.123"), expected: "5 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "6.1234"), expected: "6 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "123456.1234"), expected: "123 456 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "12345678.1234"), expected: "12 345 678 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "1234567890.1234"), expected: "1 234 567 890 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "0ds&#$ %!"), expected: "0 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$ %!1ds&#$ %!23ds&#$ %!"), expected: "123 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "0ds&#$ %!12ds&#$ %!"),  expected:"12 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "012ds&#$ %!"),  expected:"12 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "0000ds&#$ %!12"),  expected:"12 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "004ds&#$ %!0012"),  expected:"40 012 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "5ds&#$ %!123"),  expected:"5 123 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "123456vds&#$ %!"), expected: "123 456 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "1ds&#$ %!234567890"), expected: "1 234 567 890 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$ %!12345678ds&#$ %!901234"), expected: "1 234 567 890 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "1ds&#$ %!23.0"), expected: "123 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$ %!0.0ds&#$ %!"), expected: "0 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$ %!0.12"), expected: "0 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "5.12ds&#$ %!3"), expected: "5 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$ %!6.1234"), expected: "6 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$ %!12ds&#$ %!3456.1234"), expected: "123 456 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$ %!1234567ds&#$ %!8.1234"),  expected:"12 345 678 ${kzt}")
        isAssert(actual: _getMoneyFormatted(amount: "ds&#$%!12345678ds&#$ %!90.1234"), expected: "1 234 567 890 ${kzt}")
    }

    private func initMoneyAmountString(amounts: String) -> Int {
        Money.initString(amount: amounts).amount
    }

    private func initMoneyAmountDouble(amounts: Double) -> Int {
        Money.initDouble(amount: amounts).amount
    }

    private func initMoneyAmountMoney(amounts: Money) -> Int {
        Money.initMoney(amount: amounts).amount
    }

    private func initMoneyAmountInt(amount: Int) -> Int {
        Money.initInt(amount: amount).amount
    }

    private func initMoney(amount: String) -> Money {
        Money.initMoney(amount: Money(amount: Int(amount) ?? 0))
    }

    private func initMoney(amount: Int) -> Money {
        var temp = Money()
        temp.amount = amount
        return Money.initMoney(amount: temp)
    }

    private func _getMoneyFormatted(amount: String) -> String {
        getMoneyFormatted(amount: amount)
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
            actual: Int,
            expected: String
    ) {
        XCTAssertEqual(String(actual), expected)
    }

    private func isAssert(
            actual: Int,
            expected: Int
    ) {
        XCTAssertEqual(actual, expected)
    }

    private func isAssert(
            actual: Bool,
            expected: Bool
    ) {
        XCTAssertEqual(actual, expected)
    }

}
