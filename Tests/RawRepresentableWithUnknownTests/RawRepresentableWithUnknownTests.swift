import RawRepresentableWithUnknown
import XCTJSONKit

final class RawRepresentableWithUnknownTests: XCTestCase {
    enum SUT: String, CaseIterable, Codable, Equatable, RawRepresentableWithUnknown {
        case unknown
        case foo
        case bar
    }

    func testCoding() throws {
        try XCTAssertJSONCoding(SUT.self)
    }

    func testDecodingUnknownRawValue() throws {
        try XCTAssertJSONDecoding("deadbeef", SUT.unknown)
    }

    func testDecodingNullRawValue() throws {
        try XCTAssertJSONDecoding(.null, SUT?.none)
    }
}
