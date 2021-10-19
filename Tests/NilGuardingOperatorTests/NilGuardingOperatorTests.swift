#if os(macOS) || os(iOS)
import CwlPreconditionTesting
import NilGuardingOperator
import XCTest

final class NilGuardingOperatorTests: XCTestCase {

    // Possible permutations:
    //   - a
    //   - b
    //   - c
    //   - a b
    //   - a c
    //   - b a
    //   - b c
    //   - c a
    //   - c b
    //   - a b c
    //   - a c b
    //   - b a c
    //   - b c a
    //   - c a b
    //   - c b a

    func testUnwrapOrThrow() {
        // a
        assertThrows(error) {
            try noneA ?! error
        }
        // b
        assertNoThrow(someB) {
            try someB ?! error
        }
        // c
        assertNoThrow(someC) {
            try someC ?! error
        }
        // a b
        assertNoThrow(someB) {
            try noneA ?? someB ?! error
        }
        // a c
        assertNoThrow(someC) {
            try noneA ?? someC ?! error
        }
        // b a
        assertNoThrow(someB) {
            try someB ?? noneA ?! error
        }
        // b c
        assertNoThrow(someB) {
            try someB ?? someC ?! error
        }
        // c a
        assertNoThrow(someC) {
            try someC ?? noneA ?! error
        }
        // c b
        assertNoThrow(someC) {
            try someC ?? someB ?! error
        }
        // a b c
        assertNoThrow(someB) {
            try noneA ?? someB ?? someC ?! error
        }
        // a c b
        assertNoThrow(someC) {
            try noneA ?? someC ?? someB ?! error
        }
        // b a c
        assertNoThrow(someB) {
            try someB ?? noneA ?? someC ?! error
        }
        // b c a
        assertNoThrow(someB) {
            try someB ?? someC ?? noneA ?! error
        }
        // c a b
        assertNoThrow(someC) {
            try someC ?? noneA ?? someB ?! error
        }
        // c b a
        assertNoThrow(someC) {
            try someC ?? someB ?? noneA ?! error
        }
    }

    func testUnwrapOrExit() {
        // a
        XCTAssertExit {
            noneA !! exit()
        }
        // b
        XCTAssertNoExit(someB) {
            someB !! exit()
        }
        // c
        XCTAssertNoExit(someC) {
            someC !! exit()
        }
        // a b
        XCTAssertNoExit(someB) {
            noneA ?? someB !! exit()
        }
        // a c
        XCTAssertNoExit(someC) {
            noneA ?? someC !! exit()
        }
        // b a
        XCTAssertNoExit(someB) {
            someB ?? noneA !! exit()
        }
        // b c
        XCTAssertNoExit(someB) {
            someB ?? someC !! exit()
        }
        // c a
        XCTAssertNoExit(someC) {
            someC ?? noneA !! exit()
        }
        // c b
        XCTAssertNoExit(someC) {
            someC ?? someB !! exit()
        }
        // a b c
        XCTAssertNoExit(someB) {
            noneA ?? someB ?? someC !! exit()
        }
        // a c b
        XCTAssertNoExit(someC) {
            noneA ?? someC ?? someB !! exit()
        }
        // b a c
        XCTAssertNoExit(someB) {
            someB ?? noneA ?? someC !! exit()
        }
        // b c a
        XCTAssertNoExit(someB) {
            someB ?? someC ?? noneA !! exit()
        }
        // c a b
        XCTAssertNoExit(someC) {
            someC ?? noneA ?? someB !! exit()
        }
        // c b a
        XCTAssertNoExit(someC) {
            someC ?? someB ?? noneA !! exit()
        }
    }
}

private extension NilGuardingOperatorTests {
    func assertThrows<ExpectedError: Error & Equatable, DiscardedResult>(
        _ expectedError: ExpectedError,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: () throws -> DiscardedResult
    ) {
        XCTAssertThrowsError(try closure(), "Expected error was never thrown", file: file, line: line) { error in
            if let error = error as? ExpectedError {
                XCTAssertEqual(error, expectedError)
            } else {
                XCTFail("Unexpected error was thrown")
            }
        }
    }

    func assertNoThrow<ExpectedResult: Equatable>(
        _ expectedResult: ExpectedResult,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: @escaping () throws -> ExpectedResult
    ) {
        var result: ExpectedResult?
        XCTAssertNoThrow(try { result = try closure() }(), "Unexpected error was thrown", file: file, line: line)
        XCTAssertEqual(result, expectedResult)
    }
}

private extension NilGuardingOperatorTests {
    func XCTAssertExit<DiscardedResult>(
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: @escaping () -> DiscardedResult
    ) {
        let exit = catchBadInstruction { _ = closure() }
        XCTAssert(exit != nil, "Expected exit never occurred", file: file, line: line)
    }

    func XCTAssertNoExit<DiscardedResult>(
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: @escaping () -> DiscardedResult
    ) {
        let exit = catchBadInstruction { _ = closure() }
        XCTAssert(exit == nil, "Unexpected exit occurred", file: file, line: line)
    }

    func XCTAssertNoExit<ExpectedResult: Equatable>(
        _ expectedResult: ExpectedResult,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: @escaping () -> ExpectedResult
    ) {
        XCTAssertNoExit(file: file, line: line) {
            let result = closure()
            XCTAssertEqual(result, expectedResult)
        }
    }
}

private let noneA = String?.none
private let someB = String?.some("B")
private let someC = String?.some("C")
private let error = NSError(domain: XCTestErrorDomain, code: -1, userInfo: nil)
private let exit = { fatalError() }
#endif
