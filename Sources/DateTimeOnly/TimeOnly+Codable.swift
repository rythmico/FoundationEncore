import Foundation

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
