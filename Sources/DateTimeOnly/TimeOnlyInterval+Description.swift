import Foundation

extension TimeOnlyInterval: CustomStringConvertible {
    public var description: String {
        start.rawValue + " - " + end.rawValue
    }
}

extension TimeOnlyInterval: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)(start: \(start), end: \(end))"
    }
}
