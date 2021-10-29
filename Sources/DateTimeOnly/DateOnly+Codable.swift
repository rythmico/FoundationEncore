import Foundation

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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension DateOnly {
    init?(rawValue: String) {
        guard let date = Self.formatter.date(from: rawValue) else {
            return nil
        }
        self = DateOnly(date, timeZone: timeZone)
    }

    var rawValue: String {
        var dateComponents = DateComponents(self)
        dateComponents.calendar = calendar
        dateComponents.timeZone = timeZone
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
