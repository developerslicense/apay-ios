//
//  CardDateTests2.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 17.08.2023.
//

import XCTest
@testable import ApayIOS

final class CardDateTests2: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateUtilsValidation() throws {
        XCTAssertEqual(checkDateValid(date: nil), false)
        XCTAssertEqual(checkDateValid(date: ""), false)
        XCTAssertEqual(checkDateValid(date: "0"), false)
        XCTAssertEqual(checkDateValid(date: "00"), false)
        XCTAssertEqual(checkDateValid(date: "000"), false)
        XCTAssertEqual(checkDateValid(date: "0000"), false)
        XCTAssertEqual(checkDateValid(date: "1"), false)
        XCTAssertEqual(checkDateValid(date: "13"), false)
        XCTAssertEqual(checkDateValid(date: "123"), false)
        XCTAssertEqual(checkDateValid(date: "1023"), false)
        XCTAssertEqual(checkDateValid(date: "1024"), false)
        XCTAssertEqual(checkDateValid(date: "1124"), false)
        XCTAssertEqual(checkDateValid(date: "1224"), false)
        XCTAssertEqual(checkDateValid(date: "0524"), false)
        XCTAssertEqual(checkDateValid(date: "0124"), false)
        XCTAssertEqual(checkDateValid(date: "0024"), false)

        for i in (0...22) {
            checkError(month: "0", year: i)
            checkError(month: "1", year: i)
            checkError(month: "2", year: i)
            checkError(month: "3", year: i)
            checkError(month: "4", year: i)
            checkError(month: "5", year: i)
            checkError(month: "6", year: i)
            checkError(month: "7", year: i)
            checkError(month: "8", year: i)
            checkError(month: "9", year: i)
            checkError(month: "00", year: i)
            checkError(month: "13", year: i)
            checkError(month: "14", year: i)
            checkError(month: "20", year: i)
            checkError(month: "50", year: i)
            checkError(month: "01", year: i)
            checkError(month: "02", year: i)
            checkError(month: "03", year: i)
            checkError(month: "04", year: i)
            checkError(month: "05", year: i)
            checkError(month: "06", year: i)
            checkError(month: "07", year: i)
            checkError(month: "08", year: i)
            checkError(month: "09", year: i)
            checkError(month: "10", year: i)
            checkError(month: "11", year: i)
            checkError(month: "12", year: i)
        }

        for i in (24...99) {
            checkError(month: "00", year: i)
            checkError(month: "13", year: i)
            checkError(month: "14", year: i)
            checkError(month: "20", year: i)
            checkError(month: "50", year: i)
            checkSuccess(month: "01", year: i)
            checkSuccess(month: "02", year: i)
            checkSuccess(month: "03", year: i)
            checkSuccess(month: "04", year: i)
            checkSuccess(month: "05", year: i)
            checkSuccess(month: "06", year: i)
            checkSuccess(month: "07", year: i)
            checkSuccess(month: "08", year: i)
            checkSuccess(month: "09", year: i)
            checkSuccess(month: "10", year: i)
            checkSuccess(month: "11", year: i)
            checkSuccess(month: "12", year: i)
        }

        /** здесь может вылетать ошибка в зависимости от месяца нынешнего года и самого года.
         поэтому, нужно менять год и checkError с checkSuccess в зависимости от того, какой сейчас
         месяц или год. на момент написания теста это было 17е августа 2023
         поэтому, были
         let year = 2023
         checkError("08", year)
         и checkSuccess("09", year) */

        let year = 2023
        checkError(month: "0", year: year)
        checkError(month: "00", year: year)
        checkError(month: "01", year: year)
        checkError(month: "02", year: year)
        checkError(month: "03", year: year)
        checkError(month: "04", year: year)
        checkError(month: "05", year: year)
        checkError(month: "06", year: year)
        checkError(month: "07", year: year)
        checkError(month: "08", year: year)
        checkError(month: "09", year: year)
        checkSuccess(month: "10", year: year)
        checkSuccess(month: "11", year: year)
        checkSuccess(month: "12", year: year)
        checkError(month: "13", year: year)
        checkError(month: "15", year: year)
        checkError(month: "20", year: year)

    }

    private func checkSuccess(
            month: String,
            year: Int
    ) {
        XCTAssertEqual(checkDateValid(date: month + "/" + String(year)), true)
    }

    private func checkError(
            month: String,
            year: Int
    ) {
        XCTAssertEqual(checkDateValid(date: month + "/" + String(year)), false)
    }

    private func checkDateValid(date: String?) -> Bool {
        isDateValid(value: date)
    }
    
}
