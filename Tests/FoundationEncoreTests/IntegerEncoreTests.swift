import FoundationEncore
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
