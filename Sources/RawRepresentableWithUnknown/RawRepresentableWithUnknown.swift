import CasePaths

public protocol RawRepresentableWithUnknown {
    associatedtype RawValue
    associatedtype Known: RawRepresentable where Known.RawValue == RawValue

    static func known(_: Known) -> Self
    static func unknown(_: RawValue) -> Self

    init(rawValue: RawValue)
    var rawValue: RawValue { get }
}

// Remove if `RawRepresentableWithUnknown: enum` conformance is ever allowed.
extension RawRepresentableWithUnknown {
    private func `switch`<Output>(
        known: (Known) -> Output,
        unknown: (RawValue) -> Output
    ) -> Output {
        if let value = (/Self.known).extract(from: self) {
            return known(value)
        } else if let value = (/Self.unknown).extract(from: self) {
            return unknown(value)
        }
        fatalError("Matched unknown `RawRepresentableWithUnknown` enum case: \(self)")
    }
}

extension RawRepresentableWithUnknown {
    public init(rawValue: RawValue) {
        self = Known(rawValue: rawValue).map(Self.known) ?? .unknown(rawValue)
    }

    public var rawValue: RawValue {
        self.switch(
            known: \.rawValue,
            unknown: { $0 } // TODO: use \.self when possible
        )
    }
}

extension RawRepresentableWithUnknown where Self: Decodable, RawValue: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        self.init(rawValue: rawValue)
    }
}

extension RawRepresentableWithUnknown where Self: Encodable, RawValue: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension RawRepresentableWithUnknown where Self: CustomDebugStringConvertible {
    public var debugDescription: String {
        self.switch(
            known: { "\(Self.self).known(\($0))" },
            unknown: { "\(Self.self).unknown(\($0))" }
        )
    }
}

extension RawRepresentableWithUnknown where Self: Equatable, RawValue: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

extension RawRepresentableWithUnknown where Self: Hashable, RawValue: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
