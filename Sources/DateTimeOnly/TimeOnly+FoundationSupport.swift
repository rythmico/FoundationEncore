import Foundation

extension Date {
    public init(_ timeOnly: TimeOnly, timeZone: TimeZone) {
        var calendar = calendar
        calendar.timeZone = timeZone
        var dateComponents = DateComponents(timeOnly)
        dateComponents.calendar = calendar
        dateComponents.timeZone = timeZone
        guard let date = dateComponents.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        self = date
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

extension DateInterval {
    public init(start: TimeOnly, end: TimeOnly, timeZone: TimeZone) {
        self.init(
            start: Date(start, timeZone: timeZone),
            end: Date(end, timeZone: timeZone)
        )
    }
}
