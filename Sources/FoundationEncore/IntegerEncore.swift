// MARK: - Nil On Overflow -

extension BinaryInteger {
    /// Equivalent to `BinaryInteger.init?(exactly:)`, just with a more obvious name.
    public init?<T: BinaryInteger>(nilOnOverflow source: T) {
        self.init(exactly: source)
    }
}

extension FixedWidthInteger {
    public func addingOrNilOnOverflow(_ rhs: Self) -> Self? {
        let (value, overflow) = self.addingReportingOverflow(rhs)
        return overflow ? nil : value
    }

    public func dividedOrNilOnOverflow(by rhs: Self) -> Self? {
        let (value, overflow) = self.dividedReportingOverflow(by: rhs)
        return overflow ? nil : value
    }

    public func multipliedOrNilOnOverflow(by rhs: Self) -> Self? {
        let (value, overflow) = self.multipliedReportingOverflow(by: rhs)
        return overflow ? nil : value
    }

    public func remainderOrNilOnOverflow(dividingBy rhs: Self) -> Self? {
        let (value, overflow) = self.remainderReportingOverflow(dividingBy: rhs)
        return overflow ? nil : value
    }

    public func subtractingOrNilOnOverflow(_ rhs: Self) -> Self? {
        let (value, overflow) = self.subtractingReportingOverflow(rhs)
        return overflow ? nil : value
    }
}

infix operator +? : AdditionPrecedence
infix operator /? : MultiplicationPrecedence
infix operator *? : MultiplicationPrecedence
infix operator -? : AdditionPrecedence

extension FixedWidthInteger {
    public static func +? (lhs: Self, rhs: Self) -> Self? {
        lhs.addingOrNilOnOverflow(rhs)
    }

    public static func /? (lhs: Self, rhs: Self) -> Self? {
        lhs.dividedOrNilOnOverflow(by: rhs)
    }

    public static func *? (lhs: Self, rhs: Self) -> Self? {
        lhs.multipliedOrNilOnOverflow(by: rhs)
    }

    public static func -? (lhs: Self, rhs: Self) -> Self? {
        lhs.subtractingOrNilOnOverflow(rhs)
    }
}

// MARK: - Throw On Overflow -

public struct IntegerConversionOverflowError<From: BinaryInteger, To: BinaryInteger>: LocalizedError, Equatable {
    public let from: From
    public let to: To.Type

    public var errorDescription: String? {
        return "Integer overflow ocurred when converting \(From.self)(\(from)) to \(to)"
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.from == rhs.from && lhs.to == rhs.to
    }
}

public struct IntegerOperationOverflowError<LHS: BinaryInteger, RHS: BinaryInteger>: LocalizedError, Hashable {
    public enum Operation: Hashable {
        case add
        case divide
        case multiply
        case remainder
        case subtract
    }

    public let lhs: LHS
    public let operation: Operation
    public let rhs: RHS

    public var errorDescription: String? {
        switch operation {
        case .add:
            return "Integer overflow occured: \(LHS.self)(\(lhs)) + \(RHS.self)(\(rhs))"
        case .divide:
            return "Integer overflow occured: \(LHS.self)(\(lhs)) / \(RHS.self)(\(rhs))"
        case .multiply:
            return "Integer overflow occured: \(LHS.self)(\(lhs)) * \(RHS.self)(\(rhs))"
        case .remainder:
            return "Integer overflow occured: (remainder of) \(LHS.self)(\(lhs)) / \(RHS.self)(\(rhs))"
        case .subtract:
            return "Integer overflow occured: \(LHS.self)(\(lhs)) - \(RHS.self)(\(rhs))"
        }
    }
}

extension BinaryInteger {
    public init<T: BinaryInteger>(throwOnOverflow source: T) throws {
        self = try Self.init(exactly: source) ?! IntegerConversionOverflowError(from: source, to: Self.self)
    }
}

extension FixedWidthInteger {
    public func addingOrThrowOnOverflow(_ rhs: Self) throws -> Self {
        let (value, overflow) = self.addingReportingOverflow(rhs)
        if overflow {
            throw IntegerOperationOverflowError(lhs: self, operation: .add, rhs: rhs)
        } else {
            return value
        }
    }

    public func dividedOrThrowOnOverflow(by rhs: Self) throws -> Self {
        let (value, overflow) = self.dividedReportingOverflow(by: rhs)
        if overflow {
            throw IntegerOperationOverflowError(lhs: self, operation: .divide, rhs: rhs)
        } else {
            return value
        }
    }

    public func multipliedOrThrowOnOverflow(by rhs: Self) throws -> Self {
        let (value, overflow) = self.multipliedReportingOverflow(by: rhs)
        if overflow {
            throw IntegerOperationOverflowError(lhs: self, operation: .multiply, rhs: rhs)
        } else {
            return value
        }
    }

    public func remainderOrThrowOnOverflow(dividingBy rhs: Self) throws -> Self {
        let (value, overflow) = self.remainderReportingOverflow(dividingBy: rhs)
        if overflow {
            throw IntegerOperationOverflowError(lhs: self, operation: .remainder, rhs: rhs)
        } else {
            return value
        }
    }

    public func subtractingOrThrowOnOverflow(_ rhs: Self) throws -> Self {
        let (value, overflow) = self.subtractingReportingOverflow(rhs)
        if overflow {
            throw IntegerOperationOverflowError(lhs: self, operation: .subtract, rhs: rhs)
        } else {
            return value
        }
    }
}

infix operator +?! : AdditionPrecedence
infix operator /?! : MultiplicationPrecedence
infix operator *?! : MultiplicationPrecedence
infix operator -?! : AdditionPrecedence

extension FixedWidthInteger {
    public static func +?! (lhs: Self, rhs: Self) throws -> Self {
        try lhs.addingOrThrowOnOverflow(rhs)
    }

    public static func /?! (lhs: Self, rhs: Self) throws -> Self {
        try lhs.dividedOrThrowOnOverflow(by: rhs)
    }

    public static func *?! (lhs: Self, rhs: Self) throws -> Self {
        try lhs.multipliedOrThrowOnOverflow(by: rhs)
    }

    public static func -?! (lhs: Self, rhs: Self) throws -> Self {
        try lhs.subtractingOrThrowOnOverflow(rhs)
    }
}
