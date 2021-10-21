import DateTimeOnly
import XCTJSONKit

final class DateOnlyTests: XCTestCase {
    func testDecode() throws {
        try XCTAssertJSONDecoding("10300-07-14", DateOnly(year: 10300, month: 07, day: 14))
        try XCTAssertJSONDecoding("2021-07-14", DateOnly(year: 2021, month: 07, day: 14))
        try XCTAssertJSONDecoding("2019-12-03", DateOnly(year: 2019, month: 12, day: 03))
        try XCTAssertJSONDecoding("0103-12-03", DateOnly(year: 103, month: 12, day: 03))
        try XCTAssertJSONDecoding("0001-12-03", DateOnly(year: 1, month: 12, day: 03))
        try XCTAssertJSONDecoding("0001-12-03", DateOnly(year: 1, month: 12, day: 03))
        try XCTAssertJSONDecoding("0002-12-03", DateOnly(year: 2, month: 12, day: 03))
        try XCTAssertJSONDecoding(" 0121-12-03 ", DateOnly(year: 121, month: 12, day: 03))

        try XCTAssertThrowsError(XCTAssertJSONDecoding("12-03", DateOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-12-03", DateOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-0001-12-03", DateOnly?.none))
        try XCTAssertThrowsError(XCTAssertJSONDecoding("-0120-12-03", DateOnly?.none))
    }

    func testEncode() throws {
        try XCTAssertJSONEncoding(DateOnly(year: 10300, month: 07, day: 14), "10300-07-14")
        try XCTAssertJSONEncoding(DateOnly(year: 2021, month: 07, day: 14), "2021-07-14")
        try XCTAssertJSONEncoding(DateOnly(year: 2019, month: 12, day: 03), "2019-12-03")
        try XCTAssertJSONEncoding(DateOnly(year: 103, month: 12, day: 03), "0103-12-03")
        try XCTAssertJSONEncoding(DateOnly(year: 1, month: 12, day: 03), "0001-12-03")
        try XCTAssertJSONEncoding(DateOnly(year: 0, month: 12, day: 03), "0001-12-03")
        try XCTAssertJSONEncoding(DateOnly(year: -1, month: 12, day: 03), "0002-12-03")
        try XCTAssertJSONEncoding(DateOnly(year: -120, month: 12, day: 03), "0121-12-03")

        try XCTAssertJSONEncoding(DateOnly(year: -120, month: 13, day: 03), "0120-01-03")
    }

    func testComparable() {
        let sut = [
            DateOnly(year: 2019, month: 11, day: 14),
            DateOnly(year: 2020, month: 07, day: 03),
            DateOnly(year: 2020, month: 07, day: 03),
            DateOnly(year: 2021, month: 06, day: 02),
            DateOnly(year: 2021, month: 06, day: 03),
            DateOnly(year: 2021, month: 07, day: 02),
            DateOnly(year: 2021, month: 07, day: 03),
        ]
        XCTAssertEqual(sut, sut.shuffled().sorted())
    }

    func testAdd() {
        let sut = DateOnly(year: 2021, month: 10, day: 24)
        // BST to BST (DST) — but not really
        XCTAssertEqual(try sut + (1, .day), DateOnly(year: 2021, month: 10, day: 25))
        XCTAssertEqual(try sut + (3, .month), DateOnly(year: 2022, month: 01, day: 24))
        XCTAssertEqual(try sut + (3, .year), DateOnly(year: 2024, month: 10, day: 24))
        // BST to GMT (DST) — but not really
        XCTAssertEqual(try sut + (1, .weekOfYear), DateOnly(year: 2021, month: 10, day: 31))
        XCTAssertEqual(try sut + (2, .weekOfYear), DateOnly(year: 2021, month: 11, day: 07))
        XCTAssertEqual(try sut + (1, .month), DateOnly(year: 2021, month: 11, day: 24))
    }

    func testAdd_toLeapDay() {
        let sut = DateOnly(year: 2020, month: 02, day: 29) // leap day
        XCTAssertEqual(try sut + (3, .day), DateOnly(year: 2020, month: 03, day: 03))
        XCTAssertEqual(try sut + (3, .month), DateOnly(year: 2020, month: 05, day: 29))
        XCTAssertEqual(try sut + (3, .year), DateOnly(year: 2023, month: 02, day: 28))
    }

    func testSubtract() {
        let sut = DateOnly(year: 2021, month: 10, day: 24)
        // BST to BST (DST) — but not really
        XCTAssertEqual(sut, try DateOnly(year: 2021, month: 10, day: 25) - (1, .day))
        XCTAssertEqual(sut, try DateOnly(year: 2022, month: 01, day: 24) - (3, .month))
        XCTAssertEqual(sut, try DateOnly(year: 2024, month: 10, day: 24) - (3, .year))
        // GMT to BST (DST) — but not really
        XCTAssertEqual(sut, try DateOnly(year: 2021, month: 10, day: 31) - (1, .weekOfYear))
        XCTAssertEqual(sut, try DateOnly(year: 2021, month: 11, day: 07) - (2, .weekOfYear))
        XCTAssertEqual(sut, try DateOnly(year: 2021, month: 11, day: 24) - (1, .month))
    }

    func testSubtract_toLeapDay() {
        let sut = DateOnly(year: 2020, month: 02, day: 29) // leap day
        XCTAssertEqual(sut, try DateOnly(year: 2020, month: 03, day: 03) - (3, .day))
        XCTAssertEqual(sut, try DateOnly(year: 2020, month: 05, day: 29) - (3, .month))
        XCTAssertGreaterThan(sut, try DateOnly(year: 2023, month: 02, day: 28) - (3, .year))
        XCTAssertEqual(try sut - (1, .day), try DateOnly(year: 2023, month: 02, day: 28) - (3, .year))
    }

    func testDiff() {
        let sut = DateOnly(year: 2021, month: 10, day: 24) // leap day
        // BST-BST (DST) — but not really
        XCTAssertEqual(try sut - (DateOnly(year: 2021, month: 10, day: 24), .day), 0)
        XCTAssertEqual(try sut - (DateOnly(year: 2021, month: 10, day: 21), .day), 3)
        XCTAssertEqual(try sut - (DateOnly(year: 2011, month: 10, day: 24), .year), 10)
        XCTAssertEqual(try sut - (DateOnly(year: 2011, month: 10, day: 24), .month), 120)
        XCTAssertEqual(try sut - (DateOnly(year: 2021, month: 10, day: 30), .hour), -144)
    }
}
