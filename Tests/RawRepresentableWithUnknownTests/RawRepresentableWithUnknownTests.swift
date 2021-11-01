import RawRepresentableWithUnknown
import XCTJSONKit

final class RawRepresentableWithUnknownTests: XCTestCase {
    enum SUT: RawRepresentableWithUnknown, Codable, CustomDebugStringConvertible, Hashable {
        case known(KnownSUT)
        case unknown(String)
    }

    enum KnownSUT: String, CaseIterable {
        case foo
        case bar
    }

    func testInitWithRawValue() {
        XCTAssertEqual(SUT(rawValue: "foo"), .known(.foo))
        XCTAssertEqual(SUT(rawValue: "bar"), .known(.bar))
        XCTAssertEqual(SUT(rawValue: "deadbeef"), .unknown("deadbeef"))
        XCTAssertEqual(SUT(rawValue: "foobar"), .unknown("foobar"))
    }

    func testRawValue() {
        XCTAssertEqual(SUT.known(.foo).rawValue, "foo")
        XCTAssertEqual(SUT.unknown("baz").rawValue, "baz")
    }

    func testCoding() throws {
        // Known
        for knownSUT in KnownSUT.allCases {
            try XCTAssertJSONCoding(SUT.known(knownSUT))
        }
        // Unknown
        try XCTAssertJSONCoding(SUT.unknown("deadbeef"))
        try XCTAssertJSONCoding(SUT.unknown("foobar"))
    }

    func testDecodingUnknownRawValue() throws {
        // Known
        for knownSUT in KnownSUT.allCases {
            try XCTAssertJSONDecoding(.string(knownSUT.rawValue), SUT.known(knownSUT))
        }
        // Unknown
        try XCTAssertJSONDecoding("deadbeef", SUT.unknown("deadbeef"))
        try XCTAssertJSONDecoding("foobar", SUT.unknown("foobar"))
        // Null
        try XCTAssertJSONDecoding(.null, SUT?.none)
    }

    func testEncodable() throws {
        // Known
        for knownSUT in KnownSUT.allCases {
            try XCTAssertJSONEncoding(SUT.known(knownSUT), .string(knownSUT.rawValue))
        }
        // Unknown
        try XCTAssertJSONEncoding(SUT.unknown("deadbeef"), "deadbeef")
        try XCTAssertJSONEncoding(SUT.unknown("foobar"), "foobar")
    }

    func testDebugDescription() {
        // Known
        XCTAssertEqual(SUT.known(.foo).debugDescription, "SUT.known(foo)")
        XCTAssertEqual("\(SUT.known(.foo))", "SUT.known(foo)")
        // Unknown
        XCTAssertEqual(SUT.unknown("baz").debugDescription, "SUT.unknown(baz)")
        XCTAssertEqual("\(SUT.unknown("baz"))", "SUT.unknown(baz)")
    }

    func testEquatable() {
        let sut = SUT.known(.foo)
        XCTAssertEqual(sut, .known(.foo))
        XCTAssertEqual(sut, .unknown("foo"))
        XCTAssertNotEqual(sut, .known(.bar))
        XCTAssertNotEqual(sut, .unknown("bar"))
    }

    func testHashable() {
        let sut = SUT.known(.foo)
        XCTAssertEqual(sut.hashValue, SUT.known(.foo).hashValue)
        XCTAssertEqual(sut.hashValue, SUT.unknown("foo").hashValue)
        XCTAssertNotEqual(sut.hashValue, SUT.known(.bar).hashValue)
        XCTAssertNotEqual(sut.hashValue, SUT.unknown("bar").hashValue)
    }
}
