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
