public enum Knowable<Known: RawRepresentable> {
    public typealias RawValue = Known.RawValue

    case known(Known)
    case unknown(RawValue)
}

extension Knowable {
    public init(rawValue: RawValue) {
        self = Known(rawValue: rawValue).map(Self.known) ?? .unknown(rawValue)
    }

    public var rawValue: RawValue {
        switch self {
        case .known(let known):
            return known.rawValue
        case .unknown(let rawValue):
            return rawValue
        }
    }
}

extension Knowable: Decodable where RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        self.init(rawValue: rawValue)
    }
}

extension Knowable: Encodable where RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension Knowable: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .known(let known):
            return "\(Self.self).known(\(known))"
        case .unknown(let rawValue):
            return "\(Self.self).unknown(\(rawValue))"
        }
    }
}

extension Knowable: Equatable where RawValue: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension Knowable: Hashable where RawValue: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
