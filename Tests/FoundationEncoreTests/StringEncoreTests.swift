import XCTest
import FoundationEncore

final class StringEncoreTests: XCTestCase {
    func testTrimmingLineCharacters() {
        XCTAssertEqual(
            """
                 tempora
              et
            id
                 porro
                    illum
            """.trimmingLineCharacters(in: .whitespacesAndNewlines),
            """
            tempora
            et
            id
            porro
            illum
            """
        )
    }
}
