import Foundation

/// Defines the components of a date, without any information about the time.
///
/// This struct is meant as a subset of `DateComponents` with only year, month, and day.
public struct DateOnly: Hashable {
    public private(set) var year: Int
    public private(set) var month: Int
    public private(set) var day: Int

    public init(year: Int, month: Int, day: Int) {
        let components = DateComponents(
            calendar: calendar,
            timeZone: timeZone,
            year: year,
            month: month,
            day: day
        )
        guard let date = components.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        self.init(date)
    }
}

extension DateOnly {
    init(_ date: Date) {
        let dateComponents = calendar.dateComponents(in: timeZone, from: date)
        guard
            let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day
        else {
            preconditionFailure("calendar.dateComponents(in:from:) is always guaranteed to return all date components")
        }
        self.year = year
        self.month = month
        self.day = day
    }
}
