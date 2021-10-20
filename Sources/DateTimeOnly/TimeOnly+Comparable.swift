import Foundation

extension TimeOnly: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.hour == rhs.hour else {
            return lhs.hour < rhs.hour
        }
        guard lhs.minute == rhs.minute else {
            return lhs.minute < rhs.minute
        }
        return false
    }
}
