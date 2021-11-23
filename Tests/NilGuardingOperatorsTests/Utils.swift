import XCTest

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

let noneA = String?.none
let someB = String?.some("B")
let someC = String?.some("C")

let error = NSError(domain: XCTestErrorDomain, code: -1, userInfo: nil)
let exit = { fatalError() }

// TestableAssertSupport configuration

import TestableAssertSupport

func assert(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
    AssertFuncBodies.assert(condition(), message(), file, line)
}

func assertionFailure(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
    AssertFuncBodies.assertionFailure(message(), file, line)
}

func precondition(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
    AssertFuncBodies.precondition(condition(), message(), file, line)
}

func preconditionFailure(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) -> Never {
    AssertFuncBodies.preconditionFailure(message(), file, line)
}

func fatalError(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) -> Never {
    AssertFuncBodies.fatalError(message(), file, line)
}
