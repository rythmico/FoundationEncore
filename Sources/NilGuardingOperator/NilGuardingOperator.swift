infix operator !! : NilCoalescingPrecedence
infix operator ?! : NilCoalescingPrecedence

public func !! <T>(optional: T?, exit: @autoclosure () -> Never) -> T {
    guard let value = optional else {
        exit()
    }
    return value
}

public func ?! <T>(optional: T?, error: @autoclosure () -> Error) throws -> T {
    guard let value = optional else {
        throw error()
    }
    return value
}
