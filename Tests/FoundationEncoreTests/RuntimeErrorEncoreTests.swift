import FoundationEncore
import XCTest

final class RuntimeErrorEncoreTests: XCTestCase {
    func testDescriptions() {
        let sut = RuntimeError("Lorem ipsum")
        XCTAssertEqual(sut.errorDescription, "Lorem ipsum")
        XCTAssertEqual(sut.localizedDescription, "Lorem ipsum")
        XCTAssertEqual(sut.legibleLocalizedDescription, "Lorem ipsum")
    }
}
