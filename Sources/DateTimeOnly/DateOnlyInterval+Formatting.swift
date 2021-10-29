import Foundation

extension DateOnlyInterval {
    public func formatted(style: DateIntervalFormatter.Style, locale: Locale) -> String {
        dateOnlyIntervalFormatter.locale = locale
        dateOnlyIntervalFormatter.dateStyle = style
        return dateOnlyIntervalFormatter.string(
            from: Date(start, timeZone: timeZone),
            to: Date(end, timeZone: timeZone)
        )
    }
}
