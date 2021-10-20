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
}
