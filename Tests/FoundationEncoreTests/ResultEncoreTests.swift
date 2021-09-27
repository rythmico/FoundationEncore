import XCTest
import FoundationEncore

final class ResultEncoreTests: XCTestCase {
    typealias Result = Swift.Result<Int, String>

    func testInitWithValueAndError() {
        XCTAssertEqual(Result(value: 3, error: "Error"), .success(3))
        XCTAssertEqual(Result(value: 3, error: nil), .success(3))
        XCTAssertEqual(Result(value: nil, error: "Error"), .failure("Error"))
        XCTAssertNil(Result(value: nil, error: nil))
    }

    func testValue() {
        XCTAssertEqual(Result.success(3).value, 3)
        XCTAssertEqual(Result.failure("Error").value, nil)
    }

    func testError() {
        XCTAssertEqual(Result.success(3).error, nil)
        XCTAssertEqual(Result.failure("Error").error, "Error")
    }

    func testIsSuccess() {
        XCTAssertEqual(Result.success(3).isSuccess, true)
        XCTAssertEqual(Result.failure("Error").isSuccess, false)
    }

    func testIsFailure() {
        XCTAssertEqual(Result.success(3).isFailure, false)
        XCTAssertEqual(Result.failure("Error").isFailure, true)
    }
}
