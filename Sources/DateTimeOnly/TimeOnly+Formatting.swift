import Foundation

extension TimeOnly {
    public func formatted(style: DateFormatter.Style, locale: Locale) -> String {
        timeOnlyFormatter.timeStyle = style
        timeOnlyFormatter.locale = locale
        return timeOnlyFormatter.string(from: Date(self, timeZone: timeZone))
    }
}
