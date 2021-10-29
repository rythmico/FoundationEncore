import Foundation

extension TimeOnlyInterval {
    public func formatted(style: DateIntervalFormatter.Style, locale: Locale) -> String {
        timeOnlyIntervalFormatter.locale = locale
        timeOnlyIntervalFormatter.timeStyle = style
        return timeOnlyIntervalFormatter.string(
            from: Date(start, timeZone: timeZone),
            to: Date(end, timeZone: timeZone)
        )
    }
}
