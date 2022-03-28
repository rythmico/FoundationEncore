import PhoneNumberKit

extension PhoneNumberKit {
    public static let shared = PhoneNumberKit()
}

extension PhoneNumber {
    public init(e164 value: String) throws {
        self = try PhoneNumberKit.shared.parse(value, withRegion: "US", ignoreType: true)
    }
}

extension PhoneNumber: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = try! PhoneNumber(e164: value)
    }
}

extension PhoneNumber {
    public func formatted(_ format: PhoneNumberFormat) -> String {
        PhoneNumberKit.shared.format(self, toType: format)
    }
}
