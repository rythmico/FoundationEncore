import Foundation

/// Defines the components of a date, without any information about the time.
///
/// This struct is meant as a subset of `DateComponents` with only year, month, and day.
public struct DateOnly {
    public var year: Int
    public var month: Int
    public var day: Int

    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
}

extension DateOnly: Hashable {}
