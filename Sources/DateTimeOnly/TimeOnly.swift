import Foundation

/// Defines the components of a time, without any information about the date.
///
/// This struct is meant as a subset of `DateComponents` with only hour and minute.
public struct TimeOnly {
    public var hour: Int
    public var minute: Int

    public init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
}

extension TimeOnly: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid TimeOnly rawValue \"\(rawValue)\""
            )
        }
        self = _self
    }

    init?(rawValue: String) {
        guard let date = Self.formatter.date(from: rawValue) else {
            return nil
        }
        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        guard
            let hour = dateComponents.hour,
            let minute = dateComponents.minute
        else {
            return nil
        }
        self = TimeOnly(hour: hour, minute: minute)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    var rawValue: String {
        let dateComponents = DateComponents(
            calendar: calendar,
            timeZone: timeZone,
            hour: hour,
            minute: minute
        )
        guard let date = dateComponents.date else {
            preconditionFailure("`DateComponents.date` returned nil")
        }
        return Self.formatter.string(from: date)
    }

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter
    }()
}

extension TimeOnly: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.hour == rhs.hour else {
            return lhs.hour < rhs.hour
        }
        guard lhs.minute == rhs.minute else {
            return lhs.minute < rhs.minute
        }
        return false
    }
}

extension TimeOnly: Hashable {}
