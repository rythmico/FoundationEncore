import Foundation

public enum DateOnlyOperationError: LocalizedError {
    case cannotAdd(DateOnly, amount: Int, unit: Calendar.Component)
    case cannotDiff(minuend: DateOnly, subtrahend: DateOnly, unit: Calendar.Component)

    public var errorDescription: String? {
        switch self {
        case .cannotAdd(let dateOnly, let amount, let unit):
            return """
            Date addition failed:
            - Date Only: \(dateOnly)
            - Amount: \(amount)
            - Unit: \(unit)
            """
        case .cannotDiff(let minuend, let subtrahend, let unit):
            return """
            Date Only diff failed:
            - Minuend: \(minuend)
            - Subtrahend: \(subtrahend)
            - Unit: \(unit)
            """
        }
    }
}

// MARK: Add

extension DateOnly {
    public mutating func add(_ amount: Int, _ unit: Calendar.Component) throws {
        guard let newDate = calendar.date(
            byAdding: unit,
            value: amount,
            to: Date(self),
            wrappingComponents: false
        ) else {
            throw DateOnlyOperationError.cannotAdd(self, amount: amount, unit: unit)
        }
        let newDateComponents = calendar.dateComponents(in: timeZone, from: newDate)
        guard
            let newYear = newDateComponents.year,
            let newMonth = newDateComponents.month,
            let newDay = newDateComponents.day
        else {
            preconditionFailure("calendar.dateComponents(in:from:) is always guaranteed to return all date components")
        }
        self = DateOnly(year: newYear, month: newMonth, day: newDay)
    }

    public func adding(_ amount: Int, _ unit: Calendar.Component) throws -> Self {
        var _self = self
        try _self.add(amount, unit)
        return _self
    }

    public static func + (lhs: Self, rhs: (amount: Int, unit: Calendar.Component)) throws -> Self {
        try lhs.adding(rhs.amount, rhs.unit)
    }
}

private extension Date {
    init(_ dateOnly: DateOnly) {
        self.init(
            date: dateOnly,
            time: TimeOnly(hour: 0, minute: 0),
            timeZone: timeZone
        )
    }
}

// MARK: Subtract

extension DateOnly {
    public mutating func subtract(_ amount: Int, _ unit: Calendar.Component) throws {
        try self.add(-amount, unit)
    }

    public func subtracting(_ amount: Int, _ unit: Calendar.Component) throws -> Self {
        try self.adding(-amount, unit)
    }

    public static func - (lhs: Self, rhs: (amount: Int, unit: Calendar.Component)) throws -> Self {
        try lhs + (-rhs.amount, rhs.unit)
    }
}

// MARK: Diff

extension DateOnly {
    public static func diff(from minuend: Self, to subtrahend: Self, _ unit: Calendar.Component) throws -> Int {
        guard
            let diffResult = calendar.dateComponents(
                [unit],
                from: DateComponents(subtrahend),
                to: DateComponents(minuend)
            ).value(for: unit)
        else {
            throw DateOnlyOperationError.cannotDiff(minuend: minuend, subtrahend: subtrahend, unit: unit)
        }
        return diffResult
    }

    public func diffing(_ subtrahend: Self, _ unit: Calendar.Component) throws -> Int {
        try Self.diff(from: self, to: subtrahend, unit)
    }

    public static func - (lhs: Self, rhs: (other: Self, unit: Calendar.Component)) throws -> Int {
        try lhs.diffing(rhs.other, rhs.unit)
    }
}
