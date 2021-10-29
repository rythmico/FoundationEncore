import Foundation

extension TimeOnly: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(rawValue: description)
    }
}

extension TimeOnly: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension TimeOnly: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(hour: \(hour), minute: \(minute))"
    }
}
