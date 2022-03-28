import PhoneNumberKit

extension PhoneNumberKit {
    public static let shared = PhoneNumberKit()
}

extension PhoneNumber {
    public func formatted(_ format: PhoneNumberFormat) -> String {
        PhoneNumberKit.shared.format(self, toType: format)
    }
}
