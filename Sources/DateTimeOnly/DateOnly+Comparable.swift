import Foundation

extension DateOnly: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        guard lhs.year == rhs.year else {
            return lhs.year < rhs.year
        }
        guard lhs.month == rhs.month else {
            return lhs.month < rhs.month
        }
        guard lhs.day == rhs.day else {
            return lhs.day < rhs.day
        }
        return false
    }
}
