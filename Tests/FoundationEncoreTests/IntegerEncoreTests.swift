import FoundationEncore
@testable import struct FoundationEncore.IntegerConversionOverflowError
@testable import struct FoundationEncore.IntegerOperationOverflowError
import XCTest

final class IntegerEncoreTests: XCTestCase {}

extension IntegerEncoreTests {
    func testInitNilOnOverflow() {
        XCTAssertEqual(Int(nilOnOverflow: UInt(0)), 0)
        XCTAssertEqual(Int(nilOnOverflow: UInt(1000)), 1000)
        XCTAssertEqual(Int(nilOnOverflow: UInt(Int.max) - 1), .max - 1)
        XCTAssertEqual(Int(nilOnOverflow: UInt(Int.max)), .max)
        XCTAssertEqual(Int(nilOnOverflow: UInt(Int.max) + 1), nil)
        XCTAssertEqual(Int(nilOnOverflow: UInt.max), nil)
    }

    func testAddingOrNilOnOverflow() {
        XCTAssertEqual(Int.max.addingOrNilOnOverflow(-2), Int.max - 2)
        XCTAssertEqual(Int.max.addingOrNilOnOverflow(-1), Int.max - 1)
        XCTAssertEqual(Int.max.addingOrNilOnOverflow(0), Int.max)
        XCTAssertEqual(Int.max.addingOrNilOnOverflow(1), nil)
        XCTAssertEqual(Int.max.addingOrNilOnOverflow(2), nil)

        XCTAssertEqual(Int.max +? -2, Int.max - 2)
        XCTAssertEqual(Int.max +? -1, Int.max - 1)
        XCTAssertEqual(Int.max +? 0, Int.max)
        XCTAssertEqual(Int.max +? 1, nil)
        XCTAssertEqual(Int.max +? 2, nil)
    }

    func testDividedOrNilOnOverflow() {
        XCTAssertEqual(Int.max.dividedOrNilOnOverflow(by: -2), -Int.max / 2)
        XCTAssertEqual(Int.max.dividedOrNilOnOverflow(by: -1), -Int.max)
        XCTAssertEqual(Int.max.dividedOrNilOnOverflow(by: 0), nil)
        XCTAssertEqual(Int.max.dividedOrNilOnOverflow(by: 1), Int.max)
        XCTAssertEqual(Int.max.dividedOrNilOnOverflow(by: 2), Int.max / 2)

        XCTAssertEqual(Int.max /? -2, -Int.max / 2)
        XCTAssertEqual(Int.max /? -1, -Int.max)
        XCTAssertEqual(Int.max /? 0, nil)
        XCTAssertEqual(Int.max /? 1, Int.max)
        XCTAssertEqual(Int.max /? 2, Int.max / 2)
    }

    func testMultipliedOrNilOnOverflow() {
        XCTAssertEqual(Int.max.multipliedOrNilOnOverflow(by: -2), nil)
        XCTAssertEqual(Int.max.multipliedOrNilOnOverflow(by: -1), -Int.max)
        XCTAssertEqual(Int.max.multipliedOrNilOnOverflow(by: 0), 0)
        XCTAssertEqual(Int.max.multipliedOrNilOnOverflow(by: 1), Int.max)
        XCTAssertEqual(Int.max.multipliedOrNilOnOverflow(by: 2), nil)

        XCTAssertEqual(Int.max *? -2, nil)
        XCTAssertEqual(Int.max *? -1, -Int.max)
        XCTAssertEqual(Int.max *? 0, 0)
        XCTAssertEqual(Int.max *? 1, Int.max)
        XCTAssertEqual(Int.max *? 2, nil)
    }

    func testRemainderOrNilOnOverflow() {
        XCTAssertEqual(Int.max.remainderOrNilOnOverflow(dividingBy: -2), 1)
        XCTAssertEqual(Int.max.remainderOrNilOnOverflow(dividingBy: -1), 0)
        XCTAssertEqual(Int.max.remainderOrNilOnOverflow(dividingBy: 0), nil)
        XCTAssertEqual(Int.max.remainderOrNilOnOverflow(dividingBy: 1), 0)
        XCTAssertEqual(Int.max.remainderOrNilOnOverflow(dividingBy: 2), 1)
    }

    func testSubtractingOrNilOnOverflow() {
        XCTAssertEqual(Int.max.subtractingOrNilOnOverflow(-2), nil)
        XCTAssertEqual(Int.max.subtractingOrNilOnOverflow(-1), nil)
        XCTAssertEqual(Int.max.subtractingOrNilOnOverflow(0), Int.max)
        XCTAssertEqual(Int.max.subtractingOrNilOnOverflow(1), Int.max - 1)
        XCTAssertEqual(Int.max.subtractingOrNilOnOverflow(2), Int.max - 2)

        XCTAssertEqual(Int.max -? -2, nil)
        XCTAssertEqual(Int.max -? -1, nil)
        XCTAssertEqual(Int.max -? 0, Int.max)
        XCTAssertEqual(Int.max -? 1, Int.max - 1)
        XCTAssertEqual(Int.max -? 2, Int.max - 2)
    }
}

extension IntegerEncoreTests {
    func testInitThrowOnOverflow() {
        XCTAssertEqual(try Int(throwOnOverflow: UInt(0)), 0)
        XCTAssertEqual(try Int(throwOnOverflow: UInt(1000)), 1000)
        XCTAssertEqual(try Int(throwOnOverflow: UInt(Int.max) - 1), .max - 1)
        XCTAssertEqual(try Int(throwOnOverflow: UInt(Int.max)), .max)
        XCTAssertError(try Int(throwOnOverflow: UInt(Int.max) + 1), IntegerConversionOverflowError(from: UInt(Int.max) + 1, to: Int.self))
        XCTAssertError(try Int(throwOnOverflow: UInt.max), IntegerConversionOverflowError(from: UInt.max, to: Int.self))
    }

    func testAddingOrThrowOnOverflow() {
        XCTAssertEqual(try Int.max.addingOrThrowOnOverflow(-2), Int.max - 2)
        XCTAssertEqual(try Int.max.addingOrThrowOnOverflow(-1), Int.max - 1)
        XCTAssertEqual(try Int.max.addingOrThrowOnOverflow(0), Int.max)
        XCTAssertError(try Int.max.addingOrThrowOnOverflow(1), IntegerOperationOverflowError(lhs: Int.max, operation: .add, rhs: 1))
        XCTAssertError(try Int.max.addingOrThrowOnOverflow(2), IntegerOperationOverflowError(lhs: Int.max, operation: .add, rhs: 2))

        XCTAssertEqual(try Int.max +?! -2, Int.max - 2)
        XCTAssertEqual(try Int.max +?! -1, Int.max - 1)
        XCTAssertEqual(try Int.max +?! 0, Int.max)
        XCTAssertError(try Int.max +?! 1, IntegerOperationOverflowError(lhs: Int.max, operation: .add, rhs: 1))
        XCTAssertError(try Int.max +?! 2, IntegerOperationOverflowError(lhs: Int.max, operation: .add, rhs: 2))
    }

    func testDividedOrThrowOnOverflow() {
        XCTAssertEqual(try Int.max.dividedOrThrowOnOverflow(by: -2), -Int.max / 2)
        XCTAssertEqual(try Int.max.dividedOrThrowOnOverflow(by: -1), -Int.max)
        XCTAssertError(try Int.max.dividedOrThrowOnOverflow(by: 0), IntegerOperationOverflowError(lhs: Int.max, operation: .divide, rhs: 0))
        XCTAssertEqual(try Int.max.dividedOrThrowOnOverflow(by: 1), Int.max)
        XCTAssertEqual(try Int.max.dividedOrThrowOnOverflow(by: 2), Int.max / 2)

        XCTAssertEqual(try Int.max /?! -2, -Int.max / 2)
        XCTAssertEqual(try Int.max /?! -1, -Int.max)
        XCTAssertError(try Int.max /?! 0, IntegerOperationOverflowError(lhs: Int.max, operation: .divide, rhs: 0))
        XCTAssertEqual(try Int.max /?! 1, Int.max)
        XCTAssertEqual(try Int.max /?! 2, Int.max / 2)
    }

    func testMultipliedOrThrowOnOverflow() {
        XCTAssertError(try Int.max.multipliedOrThrowOnOverflow(by: -2), IntegerOperationOverflowError(lhs: Int.max, operation: .multiply, rhs: -2))
        XCTAssertEqual(try Int.max.multipliedOrThrowOnOverflow(by: -1), -Int.max)
        XCTAssertEqual(try Int.max.multipliedOrThrowOnOverflow(by: 0), 0)
        XCTAssertEqual(try Int.max.multipliedOrThrowOnOverflow(by: 1), Int.max)
        XCTAssertError(try Int.max.multipliedOrThrowOnOverflow(by: 2), IntegerOperationOverflowError(lhs: Int.max, operation: .multiply, rhs: 2))

        XCTAssertError(try Int.max *?! -2, IntegerOperationOverflowError(lhs: Int.max, operation: .multiply, rhs: -2))
        XCTAssertEqual(try Int.max *?! -1, -Int.max)
        XCTAssertEqual(try Int.max *?! 0, 0)
        XCTAssertEqual(try Int.max *?! 1, Int.max)
        XCTAssertError(try Int.max *?! 2, IntegerOperationOverflowError(lhs: Int.max, operation: .multiply, rhs: 2))
    }

    func testRemainderOrThrowOnOverflow() {
        XCTAssertEqual(try Int.max.remainderOrThrowOnOverflow(dividingBy: -2), 1)
        XCTAssertEqual(try Int.max.remainderOrThrowOnOverflow(dividingBy: -1), 0)
        XCTAssertError(try Int.max.remainderOrThrowOnOverflow(dividingBy: 0), IntegerOperationOverflowError(lhs: Int.max, operation: .remainder, rhs: 0))
        XCTAssertEqual(try Int.max.remainderOrThrowOnOverflow(dividingBy: 1), 0)
        XCTAssertEqual(try Int.max.remainderOrThrowOnOverflow(dividingBy: 2), 1)
    }

    func testSubtractingOrThrowOnOverflow() {
        XCTAssertError(try Int.max.subtractingOrThrowOnOverflow(-2), IntegerOperationOverflowError(lhs: Int.max, operation: .subtract, rhs: -2))
        XCTAssertError(try Int.max.subtractingOrThrowOnOverflow(-1), IntegerOperationOverflowError(lhs: Int.max, operation: .subtract, rhs: -1))
        XCTAssertEqual(try Int.max.subtractingOrThrowOnOverflow(0), Int.max)
        XCTAssertEqual(try Int.max.subtractingOrThrowOnOverflow(1), Int.max - 1)
        XCTAssertEqual(try Int.max.subtractingOrThrowOnOverflow(2), Int.max - 2)

        XCTAssertError(try Int.max -?! -2, IntegerOperationOverflowError(lhs: Int.max, operation: .subtract, rhs: -2))
        XCTAssertError(try Int.max -?! -1, IntegerOperationOverflowError(lhs: Int.max, operation: .subtract, rhs: -1))
        XCTAssertEqual(try Int.max -?! 0, Int.max)
        XCTAssertEqual(try Int.max -?! 1, Int.max - 1)
        XCTAssertEqual(try Int.max -?! 2, Int.max - 2)
    }
}

extension IntegerEncoreTests {
    func testErrorDescriptions() {
        XCTAssertEqual(
            IntegerConversionOverflowError(from: UInt(Int.max) + 1, to: Int.self).localizedDescription,
            "Integer overflow ocurred when converting UInt(9223372036854775808) to Int"
        )
        XCTAssertEqual(
            IntegerOperationOverflowError(lhs: Int.max, operation: .add, rhs: 1).localizedDescription,
            "Integer overflow occured: Int(9223372036854775807) + Int(1)"
        )
        XCTAssertEqual(
            IntegerOperationOverflowError(lhs: Int.max, operation: .divide, rhs: 0).localizedDescription,
            "Integer overflow occured: Int(9223372036854775807) / Int(0)"
        )
        XCTAssertEqual(
            IntegerOperationOverflowError(lhs: Int.max, operation: .multiply, rhs: -2).localizedDescription,
            "Integer overflow occured: Int(9223372036854775807) * Int(-2)"
        )
        XCTAssertEqual(
            IntegerOperationOverflowError(lhs: Int.max, operation: .remainder, rhs: 0).localizedDescription,
            "Integer overflow occured: (remainder of) Int(9223372036854775807) / Int(0)"
        )
        XCTAssertEqual(
            IntegerOperationOverflowError(lhs: Int.max, operation: .subtract, rhs: -2).localizedDescription,
            "Integer overflow occured: Int(9223372036854775807) - Int(-2)"
        )
    }
}

extension IntegerEncoreTests {
    func XCTAssertError<T, E>(
        _ subject: @autoclosure () throws -> T,
        _ expectedError: E,
        file: StaticString = #file,
        line: UInt = #line
    ) where E: Error, E: Equatable {
        XCTAssertThrowsError(try subject(), file: file, line: line) { error in
            guard let error = error as? E else {
                XCTFail("Received error of unexpected type: \(error)", file: file, line: line)
                return
            }
            XCTAssertEqual(error, expectedError, file: file, line: line)
        }
    }
}
