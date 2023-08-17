//
//  CardLuhnAlgorithmTests2.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 17.08.2023.
//

import XCTest
@testable import ApayIOS

final class CardLuhnAlgorithmTests2: XCTestCase {//todo

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLuhnAlgorithm() throws {

        // success
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "6250941006528599"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "60115564485789458"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "6011000991300009"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "5425233430109903"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "2222420000001113"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "4263982640269299"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "4917484589897107"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "4001919257537193"), expected: true)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "411111111111111"), expected: false)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "5392150002388575"), expected: true)

        // failure
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "378282246310005"), expected: false)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "411111111111112"), expected: false)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "411111111111113"), expected: false)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "5392250002388575"), expected: false)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "5392150502388575"), expected: false)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "5392150002318575"), expected: false)
        isAssert(actual: _validateCardNumWithLuhnAlgorithm(number: "5392150802388575"), expected: false)

    }

    private func _validateCardNumWithLuhnAlgorithm(number: String?)-> Bool {
        validateCardNumWithLuhnAlgorithm(number: number)
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
