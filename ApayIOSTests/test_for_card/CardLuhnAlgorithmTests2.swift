//
//  CardLuhnAlgorithmTests2.swift
//  ApayIOSTests
//
//  Created by Mikhail Belikov on 17.08.2023.
//

import XCTest
@testable import ApayIOS

final class CardLuhnAlgorithmTests2: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLuhnAlgorithm() throws {

        // success
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "5392150002388575"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "4111111111111111"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "6250941006528599"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "6011000991300009"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "5425233430109903"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "2222420000001113"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "4263982640269299"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "4917484589897107"), true)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "4001919257537193"), true)

        // failure
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "41111111111111"), false)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "378282246310005"), false)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "411111111111112"), false)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "411111111111113"), false)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "5392250002388575"), false)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "5392150502388575"), false)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "5392150002318575"), false)
        XCTAssertEqual(_validateCardNumWithLuhnAlgorithm(number: "5392150802388575"), false)

    }

    private func _validateCardNumWithLuhnAlgorithm(number: String?)-> Bool {
        validateCardNumWithLuhnAlgorithm(number: number ?? "")
    }

}
