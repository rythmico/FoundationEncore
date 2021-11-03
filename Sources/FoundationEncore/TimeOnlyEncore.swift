public enum TimeOnlyEncoreOperationError: LocalizedError {
    case cannotAddPeriod(TimeOnly, Period)
    case cannotAddDuration(TimeOnly, Duration)
    case cannotAddPeriodDuration(TimeOnly, PeriodDuration)

    public var errorDescription: String? {
        switch self {
        case .cannotAddPeriod(let dateOnly, let period):
            return """
            Time addition failed:
            - Time Only: \(dateOnly)
            - Period: \(period)
            """
        case .cannotAddDuration(let dateOnly, let duration):
            return """
            Time addition failed:
            - Time Only: \(dateOnly)
            - Duration: \(duration)
            """
        case .cannotAddPeriodDuration(let dateOnly, let periodDuration):
            return """
            Time addition failed:
            - Time Only: \(dateOnly)
            - Period & Duration: \(periodDuration)
            """
        }
    }
}

extension TimeOnly {
    public static func + (lhs: Self, rhs: PeriodDuration) throws -> Self {
        guard let newDate = calendar.date(
            byAdding: rhs.asDateComponents,
            to: Date(lhs, timeZone: timeZone),
            wrappingComponents: false
        ) else {
            throw TimeOnlyEncoreOperationError.cannotAddPeriodDuration(lhs, rhs)
        }
        return TimeOnly(newDate, timeZone: timeZone)
    }

    public static func - (lhs: Self, rhs: PeriodDuration) throws -> Self {
        try lhs + -rhs
    }
}

extension TimeOnly {
    public static func + (lhs: Self, rhs: Period) throws -> Self {
        do {
            return try lhs + PeriodDuration(period: rhs)
        } catch is TimeOnlyEncoreOperationError {
            throw TimeOnlyEncoreOperationError.cannotAddPeriod(lhs, rhs)
        }
    }

    public static func - (lhs: Self, rhs: Period) throws -> Self {
        try lhs + -rhs
    }
}

extension TimeOnly {
    public static func + (lhs: Self, rhs: Duration) throws -> Self {
        do {
            return try lhs + PeriodDuration(duration: rhs)
        } catch is TimeOnlyEncoreOperationError {
            throw TimeOnlyEncoreOperationError.cannotAddDuration(lhs, rhs)
        }
    }

    public static func - (lhs: Self, rhs: Duration) throws -> Self {
        try lhs + -rhs
    }
}

private let locale = Locale.neutral
private let timeZone = TimeZone.neutral
private let calendar = Calendar.neutral
