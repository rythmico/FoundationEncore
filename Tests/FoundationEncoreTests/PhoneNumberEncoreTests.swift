import FoundationEncore
@testable import struct PhoneNumberKit.PhoneNumber // imports internal PhoneNumber.init
import XCTest

final class PhoneNumberEncoreTests: XCTestCase {
    func testFormatted_ukPhoneNumber() {
        let sut = PhoneNumber(
            numberString: "+441632960015",
            countryCode: 44,
            leadingZero: false,
            nationalNumber: 1632960015,
            numberExtension: nil,
            type: .unknown,
            regionID: "GB"
        )
        XCTAssertEqual(sut.formatted(.e164), "+441632960015")
        XCTAssertEqual(sut.formatted(.national), "01632 960015")
        XCTAssertEqual(sut.formatted(.international), "+44 1632 960015")
    }

    func testFormatted_notPhoneNumber() {
        let sut = PhoneNumber.notPhoneNumber()
        XCTAssertEqual(sut.formatted(.e164), "+00")
        XCTAssertEqual(sut.formatted(.national), "0")
        XCTAssertEqual(sut.formatted(.international), "+0 0")
    }
}
