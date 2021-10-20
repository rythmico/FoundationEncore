import Foundation

/// Defines the components of a time, without any information about the date.
///
/// This struct is meant as a subset of `DateComponents` with only hour and minute.
public struct TimeOnly {
    public var hour: Int
    public var minute: Int

    public init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
}

extension TimeOnly: Hashable {}
