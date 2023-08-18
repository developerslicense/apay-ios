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

        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: 0)),  0)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: 123)),  123)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: "012")),  12)
        XCTAssertEqual(String(initMoneyAmountMoney(amounts: initMoney(amount: "012"))),  "12")
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: "0012")),  12)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: "000012")),  12)
        XCTAssertEqual(String(initMoneyAmountMoney(amounts: initMoney(amount: "000012"))),  "12")
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: "0000120")),  120)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: "00001020")),  1020)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: 5123)),  5123)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: 123456)),  123456)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: 1234567890)),  1234567890)
        XCTAssertEqual(initMoneyAmountMoney(amounts: initMoney(amount: "12345678901234")),  1234567890)

        XCTAssertEqual(initMoneyAmountInt(amount: 0),  0)
        XCTAssertEqual(initMoneyAmountInt(amount: 123),  123)
        XCTAssertEqual(initMoneyAmountInt(amount: 5123),  5123)
        XCTAssertEqual(initMoneyAmountInt(amount: 123456),  123456)
        XCTAssertEqual(initMoneyAmountInt(amount: 1234567890),  1234567890)
        XCTAssertEqual(initMoneyAmountInt(amount: 12345678901234),  1234567890)

        XCTAssertEqual(initMoneyAmountDouble(amounts: 0.0),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 123.0),  123)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 0.0),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 00.0),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 0000.0),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 0.12),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 00.12),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 0000.12),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 0000.1200),  0)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 5.123),  5)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 6.1234),  6)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 123456.1234),  123456)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 12345678.1234),  12345678)
        XCTAssertEqual(initMoneyAmountDouble(amounts: 1234567890.1234),  1234567890)


        XCTAssertEqual(initMoneyAmountString(amounts: "0"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "123"),  123)
        XCTAssertEqual(initMoneyAmountString(amounts: "012"),  12)
        XCTAssertEqual(String(initMoneyAmountString(amounts: "012")),  "12")
        XCTAssertEqual(String(initMoneyAmountString(amounts: "000012")),  "12")
        XCTAssertEqual(String(initMoneyAmountString(amounts: "0040012")),  "40012")
        XCTAssertEqual(initMoneyAmountString(amounts: "5123"),  5123)
        XCTAssertEqual(initMoneyAmountString(amounts: "123456"),  123456)
        XCTAssertEqual(initMoneyAmountString(amounts: "1234567890"),  1234567890)
        XCTAssertEqual(initMoneyAmountString(amounts: "12345678901234"),  1234567890)
        XCTAssertEqual(initMoneyAmountString(amounts: "0"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "123.0"),  123)
        XCTAssertEqual(initMoneyAmountString(amounts: "0.0"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "0.12"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "5.123"),  5)
        XCTAssertEqual(initMoneyAmountString(amounts: "6.1234"),  6)
        XCTAssertEqual(initMoneyAmountString(amounts: "123456.1234"),  123456)
        XCTAssertEqual(initMoneyAmountString(amounts: "12345678.1234"),  12345678)
        XCTAssertEqual(initMoneyAmountString(amounts: "1234567890.1234"),  1234567890)
        XCTAssertEqual(initMoneyAmountString(amounts: "0ds&#$ %!"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!1ds&#$ %!23ds&#$ %!"),  123)
        XCTAssertEqual(initMoneyAmountString(amounts: "0ds&#$ %!12ds&#$ %!"),  12)
        XCTAssertEqual(String(initMoneyAmountString(amounts: "012ds&#$ %!")),  "12")
        XCTAssertEqual(String(initMoneyAmountString(amounts: "0000ds&#$ %!12")),  "12")
        XCTAssertEqual(String(initMoneyAmountString(amounts: "004ds&#$ %!0012")),  "40012")
        XCTAssertEqual(initMoneyAmountString(amounts: "5ds&#$ %!123"),  5123)
        XCTAssertEqual(initMoneyAmountString(amounts: "123456vds&#$ %!"),  123456)
        XCTAssertEqual(initMoneyAmountString(amounts: "1ds&#$ %!234567890"),  1234567890)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!12345678ds&#$ %!901234"),  1234567890)
        XCTAssertEqual(initMoneyAmountString(amounts: "0"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "1ds&#$ %!23.0"),  123)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!0.0ds&#$ %!"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!0.12"),  0)
        XCTAssertEqual(initMoneyAmountString(amounts: "5.12ds&#$ %!3"),  5)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!6.1234"),  6)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!12ds&#$ %!3456.1234"),  123456)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!1234567ds&#$ %!8.1234"),  12345678)
        XCTAssertEqual(initMoneyAmountString(amounts: "ds&#$ %!12345678ds&#$ %!90.1234"),  1234567890)


        XCTAssertEqual(_getMoneyFormatted(amount: "0"),  "0 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "123"),  "123 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "012"),  "12 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "012"),  "12 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "000012"),  "12 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "0040012"),  "40 012 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "5123"),  "5 123 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "123456"),  "123 456 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "1234567890"),  "1 234 567 890 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "12345678901234"),  "1 234 567 890 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "123.0"),  "123 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "0.0"),  "0 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "0.12"),  "0 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "5.123"),  "5 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "6.1234"),  "6 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "123456.1234"),  "123 456 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "12345678.1234"),  "12 345 678 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "1234567890.1234"),  "1 234 567 890 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "0ds&#$ %!"),  "0 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$ %!1ds&#$ %!23ds&#$ %!"),  "123 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "0ds&#$ %!12ds&#$ %!"),  "12 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "012ds&#$ %!"),  "12 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "0000ds&#$ %!12"),  "12 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "004ds&#$ %!0012"),  "40 012 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "5ds&#$ %!123"),  "5 123 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "123456vds&#$ %!"),  "123 456 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "1ds&#$ %!234567890"),  "1 234 567 890 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$ %!12345678ds&#$ %!901234"),  "1 234 567 890 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "1ds&#$ %!23.0"),  "123 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$ %!0.0ds&#$ %!"),  "0 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$ %!0.12"),  "0 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "5.12ds&#$ %!3"),  "5 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$ %!6.1234"),  "6 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$ %!12ds&#$ %!3456.1234"),  "123 456 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$ %!1234567ds&#$ %!8.1234"),  "12 345 678 " + kzt)
        XCTAssertEqual(_getMoneyFormatted(amount: "ds&#$%!12345678ds&#$ %!90.1234"),  "1 234 567 890 " + kzt)
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
    
}
