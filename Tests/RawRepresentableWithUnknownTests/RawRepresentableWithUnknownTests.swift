import RawRepresentableWithUnknown
import XCTJSONKit

final class RawRepresentableWithUnknownTests: XCTestCase {
    enum SUT: String, CaseIterable, Codable, Equatable, RawRepresentableWithUnknown {
        case unknown
        case foo
        case bar
    }

    func testInitWithRawValueOrUnknown_knownRawValues() {
        for sut in SUT.allCases {
            XCTAssertEqual(SUT(rawValue: sut.rawValue), sut)
        }
    }

    func testInitWithRawValueOrUnknown_unknownRawValues() {
        XCTAssertEqual(SUT(rawValueOrUnknown: "deadbeef"), .unknown)
        XCTAssertEqual(SUT(rawValueOrUnknown: "foobar"), .unknown)
    }

    func testCoding() throws {
        try XCTAssertJSONCoding(SUT.self)
    }

    func testDecodingUnknownRawValue() throws {
        try XCTAssertJSONDecoding("deadbeef", SUT.unknown)
        try XCTAssertJSONDecoding("foobar", SUT.unknown)
    }

    func testDecodingNullRawValue() throws {
        try XCTAssertJSONDecoding(.null, SUT?.none)
    }
}
