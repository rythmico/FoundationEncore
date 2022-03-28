import FoundationEncore
@testable import struct PhoneNumberKit.PhoneNumber // imports internal PhoneNumber.init
import enum PhoneNumberKit.PhoneNumberError
import XCTest

final class PhoneNumberEncoreTests: XCTestCase {
    let sut = PhoneNumber(
        numberString: "+441632960015",
        countryCode: 44,
        leadingZero: false,
        nationalNumber: 1632960015,
        numberExtension: nil,
        type: .unknown,
        regionID: "GB"
    )

    func testInitWithE164_ukPhoneNumber() {
        XCTAssertEqual(sut, try PhoneNumber(e164: "+441632960015"))
    }

    func testInitWithStringLiteral_ukPhoneNumber() {
        XCTAssertEqual(sut, "+441632960015")
    }

    func testInitWithE164_invalidPhoneNumber() {
        XCTAssertThrowsError(try PhoneNumber(e164: "+00")) { error in
            switch error {
            case PhoneNumberError.notANumber:
                break
            default:
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testFormatted_ukPhoneNumber() {
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
