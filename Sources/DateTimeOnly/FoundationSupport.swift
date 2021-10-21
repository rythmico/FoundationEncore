import Foundation

extension Date {
    public init(date: DateOnly, time: TimeOnly, timeZone: TimeZone) {
        var calendar = calendar
        calendar.timeZone = timeZone
        let dateComponents = DateComponents(
            calendar: calendar,
            timeZone: timeZone,
            year: date.year,
            month: date.month,
            day: date.day,
            hour: time.hour,
            minute: time.minute
        )
        guard let date = dateComponents.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        self = date
    }
}

extension DateOnly {
    public var asDateComponents: DateComponents {
        DateComponents(self)
    }
}

extension DateComponents {
    public init(_ dateOnly: DateOnly) {
        self.init(
            year: dateOnly.year,
            month: dateOnly.month,
            day: dateOnly.day
        )
    }
}

extension TimeOnly {
    public var asDateComponents: DateComponents {
        DateComponents(self)
    }
}

extension DateComponents {
    public init(_ timeOnly: TimeOnly) {
        self.init(
            hour: timeOnly.hour,
            minute: timeOnly.minute
        )
    }
}
