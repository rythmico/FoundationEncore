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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension TimeOnly {
    init?(rawValue: String) {
        guard let date = Self.formatter.date(from: rawValue) else {
            return nil
        }
        self = TimeOnly(date, for: timeZone)
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
        formatter.dateFormat = "HH:mm"
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter
    }()
}
