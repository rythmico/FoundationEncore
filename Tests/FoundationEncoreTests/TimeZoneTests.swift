import XCTest
import FoundationEncore

final class TimeZoneEncoreTests: XCTestCase {
    func testID() {
        XCTAssertEqual(TimeZone(identifier: "Europe/London")?.id, "Europe/London")
        XCTAssertEqual(TimeZone(id: "Europe/London")?.identifier, "Europe/London")
    }
}
