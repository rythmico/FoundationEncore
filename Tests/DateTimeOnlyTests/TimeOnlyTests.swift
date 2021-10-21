import DateTimeOnly
import XCTJSONKit

final class TimeOnlyTests: XCTestCase {}

extension TimeOnlyTests {
    func testInit() {
        XCTAssertEqual(
            TimeOnly(hour: 20, minute: 10),
            TimeOnly(hour: 20, minute: 10)
        )
        XCTAssertEqual(
            TimeOnly(hour: 19, minute: 10),
            TimeOnly(hour: 19, minute: 10)
        )
        XCTAssertEqual(
            TimeOnly(hour: 18, minute: 15),
            TimeOnly(hour: 18, minute: 15)
        )
        XCTAssertEqual(
            TimeOnly(hour: 05, minute: 50),
            TimeOnly(hour: 05, minute: 50)
        )
        XCTAssertEqual(
            TimeOnly(hour: 00, minute: 30),
            TimeOnly(hour: 00, minute: 30)
        )
        XCTAssertEqual(
            TimeOnly(hour: 00, minute: 00),
            TimeOnly(hour: 00, minute: 00)
        )
        XCTAssertEqual(
            TimeOnly(hour: -1, minute: 12),
            TimeOnly(hour: 23, minute: 12)
        )
        XCTAssertEqual(
            TimeOnly(hour: -120, minute: 12),
            TimeOnly(hour: 00, minute: 12)
        )
        XCTAssertEqual(
            TimeOnly(hour: -120, minute: 13),
            TimeOnly(hour: 00, minute: 13)
        )

        // Edge cases
        XCTAssertEqual(
            TimeOnly(hour: .min, minute: .min),
            TimeOnly(hour: 00, minute: 00)
        )
        XCTAssertEqual(
            TimeOnly(hour: .max, minute: .max),
            TimeOnly(hour: 00, minute: 00)
        )
    }
}

extension TimeOnlyTests {
    func testDecode() throws {
        try XCTAssertJSONDecoding("20:10", TimeOnly(hour: 20, minute: 10))
        try XCTAssertJSONDecoding("19:10", TimeOnly(hour: 19, minute: 10))
        try XCTAssertJSONDecoding("18:15", TimeOnly(hour: 18, minute: 15))
        try XCTAssertJSONDecoding("05:50", TimeOnly(hour: 05, minute: 50))
        try XCTAssertJSONDecoding("00:30", TimeOnly(hour: 00, minute: 30))
        try XCTAssertJSONDecoding("00:00", TimeOnly(hour: 00, minute: 00))
        try XCTAssertJSONDecoding("23:12", TimeOnly(hour: 23, minute: 12))
        try XCTAssertJSONDecoding(" 00:12 ", TimeOnly(hour: 00, minute: 12))

        XCTAssertThrowsError(try XCTAssertJSONDecoding("25:05", TimeOnly?.none))
        XCTAssertThrowsError(try XCTAssertJSONDecoding("-12:03", TimeOnly?.none))
    }

    func testEncode() throws {
        try XCTAssertJSONEncoding(TimeOnly(hour: 20, minute: 10), "20:10")
        try XCTAssertJSONEncoding(TimeOnly(hour: 19, minute: 10), "19:10")
        try XCTAssertJSONEncoding(TimeOnly(hour: 18, minute: 15), "18:15")
        try XCTAssertJSONEncoding(TimeOnly(hour: 05, minute: 50), "05:50")
        try XCTAssertJSONEncoding(TimeOnly(hour: 00, minute: 30), "00:30")
        try XCTAssertJSONEncoding(TimeOnly(hour: 00, minute: 00), "00:00")
        try XCTAssertJSONEncoding(TimeOnly(hour: -1, minute: 12), "23:12")
        try XCTAssertJSONEncoding(TimeOnly(hour: -120, minute: 12), "00:12")
        try XCTAssertJSONEncoding(TimeOnly(hour: -120, minute: 13), "00:13")
    }
}

extension TimeOnlyTests {
    func testComparable() {
        let sut = [
            TimeOnly(hour: 00, minute: 00),
            TimeOnly(hour: 00, minute: 00),
            TimeOnly(hour: 00, minute: 30),
            TimeOnly(hour: 05, minute: 50),
            TimeOnly(hour: 18, minute: 15),
            TimeOnly(hour: 19, minute: 10),
            TimeOnly(hour: 20, minute: 10),
        ]
        XCTAssertEqual(sut, sut.shuffled().sorted())
    }
}

extension TimeOnlyTests {
    func testLosslessStringConvertible() {
        XCTAssertEqual(String(TimeOnly(hour: 05, minute: 07)), "05:07")

        XCTAssertEqual(String(TimeOnly(hour: 13, minute: 25)), "13:25")
    }

    func testCustomStringConvertible() {
        XCTAssertEqual(String(describing: TimeOnly(hour: 05, minute: 07)), "05:07")
        XCTAssertEqual(TimeOnly(hour: 05, minute: 07).description, "05:07")
        XCTAssertEqual("\(TimeOnly(hour: 05, minute: 07))", "05:07")

        XCTAssertEqual(String(describing: TimeOnly(hour: 13, minute: 25)), "13:25")
        XCTAssertEqual(TimeOnly(hour: 13, minute: 25).description, "13:25")
        XCTAssertEqual("\(TimeOnly(hour: 13, minute: 25))", "13:25")
    }

    func testCustomDebugStringConvertible() {
        XCTAssertEqual(
            String(reflecting: TimeOnly(hour: 05, minute: 07)),
            "TimeOnly(hour: 5, minute: 7)"
        )
        XCTAssertEqual(
            TimeOnly(hour: 05, minute: 07).debugDescription,
            "TimeOnly(hour: 5, minute: 7)"
        )

        XCTAssertEqual(
            String(reflecting: TimeOnly(hour: 13, minute: 25)),
            "TimeOnly(hour: 13, minute: 25)"
        )
        XCTAssertEqual(
            TimeOnly(hour: 13, minute: 25).debugDescription,
            "TimeOnly(hour: 13, minute: 25)"
        )
    }
}

extension TimeOnlyTests {
    func testAdd() {
        let sut = TimeOnly(hour: 05, minute: 07)

        XCTAssertEqual(try sut + (30, .second), TimeOnly(hour: 05, minute: 07))
        XCTAssertEqual(try sut + (60, .second), TimeOnly(hour: 05, minute: 08))
        XCTAssertEqual(try sut + (1, .hour), TimeOnly(hour: 06, minute: 07))
        XCTAssertEqual(try sut + (3, .minute), TimeOnly(hour: 05, minute: 10))
        XCTAssertEqual(try sut + (14, .hour), TimeOnly(hour: 19, minute: 07))
        XCTAssertEqual(try sut + (28, .hour), TimeOnly(hour: 09, minute: 07))

        XCTAssertEqual(try sut + (1, .day), TimeOnly(hour: 05, minute: 07))
        XCTAssertEqual(try sut + (1, .weekOfYear), TimeOnly(hour: 05, minute: 07))
        XCTAssertEqual(try sut + (2, .weekOfYear), TimeOnly(hour: 05, minute: 07))
        XCTAssertEqual(try sut + (3, .month), TimeOnly(hour: 05, minute: 07))
        XCTAssertEqual(try sut + (3, .year), TimeOnly(hour: 05, minute: 07))
    }

    func testSubtract() {
        let sut = TimeOnly(hour: 05, minute: 07)

        XCTAssertEqual(TimeOnly(hour: 05, minute: 06), try TimeOnly(hour: 05, minute: 07) - (30, .second))
        XCTAssertEqual(sut, try TimeOnly(hour: 05, minute: 08) - (60, .second))
        XCTAssertEqual(sut, try TimeOnly(hour: 06, minute: 07) - (1, .hour))
        XCTAssertEqual(sut, try TimeOnly(hour: 05, minute: 10) - (3, .minute))
        XCTAssertEqual(sut, try TimeOnly(hour: 19, minute: 07) - (14, .hour))
        XCTAssertEqual(sut, try TimeOnly(hour: 09, minute: 07) - (28, .hour))

        XCTAssertEqual(sut, try TimeOnly(hour: 05, minute: 07) - (1, .day))
        XCTAssertEqual(sut, try TimeOnly(hour: 05, minute: 07) - (1, .weekOfYear))
        XCTAssertEqual(sut, try TimeOnly(hour: 05, minute: 07) - (2, .weekOfYear))
        XCTAssertEqual(sut, try TimeOnly(hour: 05, minute: 07) - (3, .month))
        XCTAssertEqual(sut, try TimeOnly(hour: 05, minute: 07) - (3, .year))
    }

    func testDiff() {
        let sut = TimeOnly(hour: 13, minute: 25)

        XCTAssertEqual(try sut - (TimeOnly(hour: 00, minute: 00), .day), 0)
        XCTAssertEqual(try sut - (TimeOnly(hour: 05, minute: 07), .day), 0)
        XCTAssertEqual(try sut - (TimeOnly(hour: 05, minute: 07), .month), 0)
        XCTAssertEqual(try sut - (TimeOnly(hour: 05, minute: 07), .year), 0)

        XCTAssertEqual(try sut - (TimeOnly(hour: 05, minute: 07), .hour), 8)
        XCTAssertEqual(try sut - (TimeOnly(hour: 13, minute: 22), .hour), 0)
        XCTAssertEqual(try sut - (TimeOnly(hour: 13, minute: 22), .minute), 3)
        XCTAssertEqual(try sut - (TimeOnly(hour: 13, minute: 25), .minute), 0)
        XCTAssertEqual(try sut - (TimeOnly(hour: 13, minute: 24), .second), 60)
        XCTAssertEqual(try sut - (TimeOnly(hour: 05, minute: 25), .second), 8 * 3600)
    }
}
