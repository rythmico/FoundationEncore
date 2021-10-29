import Foundation

extension DateOnlyInterval: CustomStringConvertible {
    public var description: String {
        start.rawValue + " - " + end.rawValue
    }
}

extension DateOnlyInterval: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(start: \(start), end: \(end))"
    }
}
