import Foundation

extension DateOnly {
    public func formatted(style: DateFormatter.Style, locale: Locale) -> String {
        dateOnlyFormatter.dateStyle = style
        dateOnlyFormatter.locale = locale
        return dateOnlyFormatter.string(from: Date(self, timeZone: timeZone))
    }
}
