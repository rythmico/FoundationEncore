import FoundationEncore
import XCTest

final class NSErrorEncoreTests: XCTestCase {
    func testInitWithDomainCodeLocalizedDescription() {
        let sut = NSError(domain: "ErrorEncoreDomain", code: -1, localizedDescription: "Lorem ipsum")
        XCTAssertEqual(sut.domain, "ErrorEncoreDomain")
        XCTAssertEqual(sut.code, -1)
        XCTAssertEqual(sut.localizedDescription, "Lorem ipsum")
        XCTAssertEqual((sut as Error).localizedDescription, "Lorem ipsum")
    }
}
