import Foundation

extension DateOnly: LosslessStringConvertible {
    public init?(_ description: String) {
        self.init(rawValue: description)
    }
}

extension DateOnly: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension DateOnly: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(year: \(year), month: \(month), day: \(day))"
    }
}
