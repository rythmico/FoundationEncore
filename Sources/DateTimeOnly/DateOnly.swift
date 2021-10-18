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

extension DateOnly: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid DateOnly rawValue \"\(rawValue)\""
            )
        }
        self = _self
    }

    init?(rawValue: String) {
        guard let date = Self.formatter.date(from: rawValue) else {
            return nil
        }
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        guard
            let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day
        else {
            return nil
        }
        self = DateOnly(year: year, month: month, day: day)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    var rawValue: String {
        let dateComponents = DateComponents(
            calendar: calendar,
            timeZone: timeZone,
            year: year,
            month: month,
            day: day
        )
        guard let date = dateComponents.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        return Self.formatter.string(from: date)
    }

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter
    }()
}

extension DateOnly: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.year != rhs.year else {
            return lhs.year < rhs.year
        }
        guard lhs.month != rhs.month else {
            return lhs.month < rhs.month
        }
        guard lhs.day != rhs.day else {
            return lhs.day < rhs.day
        }
        return false
    }
}

extension DateOnly: Hashable {}
