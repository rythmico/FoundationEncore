import DateTimeOnly
import XCTJSONKit

final class TimeOnlyTests: XCTestCase {}

extension TimeOnlyTests {
    func testInit() throws {
        try XCTAssertEqual(
            TimeOnly(hour: 20, minute: 10),
            TimeOnly(hour: 20, minute: 10)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 19, minute: 10),
            TimeOnly(hour: 19, minute: 10)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 18, minute: 15),
            TimeOnly(hour: 18, minute: 15)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 05, minute: 50),
            TimeOnly(hour: 05, minute: 50)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 00, minute: 30),
            TimeOnly(hour: 00, minute: 30)
        )
        try XCTAssertEqual(
            TimeOnly(hour: 00, minute: 00),
            TimeOnly(hour: 00, minute: 00)
        )
        try XCTAssertEqual(
            TimeOnly(hour: -1, minute: 12),
            TimeOnly(hour: 23, minute: 12)
        )
        try XCTAssertEqual(
            TimeOnly(hour: -120, minute: 12),
            TimeOnly(hour: 00, minute: 12)
        )
        try XCTAssertEqual(
            TimeOnly(hour: -120, minute: 13),
            TimeOnly(hour: 00, minute: 13)
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

        try XCTAssertThrowsError(XCTAssertJSONDecoding("25:05", TimeOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-12:03", TimeOnly?.none))
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
    func testComparable() throws {
        let sut = try [
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
        try XCTAssertEqual(String(TimeOnly(hour: 05, minute: 07)), "05:07")

        try XCTAssertEqual(String(TimeOnly(hour: 13, minute: 25)), "13:25")
    }

    func testCustomStringConvertible() {
        try XCTAssertEqual(String(describing: TimeOnly(hour: 05, minute: 07)), "05:07")
        try XCTAssertEqual(TimeOnly(hour: 05, minute: 07).description, "05:07")
        try XCTAssertEqual("\(TimeOnly(hour: 05, minute: 07))", "05:07")

        try XCTAssertEqual(String(describing: TimeOnly(hour: 13, minute: 25)), "13:25")
        try XCTAssertEqual(TimeOnly(hour: 13, minute: 25).description, "13:25")
        try XCTAssertEqual("\(TimeOnly(hour: 13, minute: 25))", "13:25")
    }

    func testCustomDebugStringConvertible() {
        try XCTAssertEqual(
            String(reflecting: TimeOnly(hour: 05, minute: 07)),
            "TimeOnly(hour: 5, minute: 7)"
        )
        try XCTAssertEqual(
            TimeOnly(hour: 05, minute: 07).debugDescription,
            "TimeOnly(hour: 5, minute: 7)"
        )

        try XCTAssertEqual(
            String(reflecting: TimeOnly(hour: 13, minute: 25)),
            "TimeOnly(hour: 13, minute: 25)"
        )
        try XCTAssertEqual(
            TimeOnly(hour: 13, minute: 25).debugDescription,
            "TimeOnly(hour: 13, minute: 25)"
        )
    }
}
