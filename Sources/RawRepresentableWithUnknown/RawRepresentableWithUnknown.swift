public protocol RawRepresentableWithUnknown: RawRepresentable {
    static var unknown: Self { get }
}

extension RawRepresentableWithUnknown where Self: Decodable, RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        self = Self(rawValue: rawValue) ?? .unknown
    }
}

extension RawRepresentableWithUnknown where Self: Encodable, RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}
