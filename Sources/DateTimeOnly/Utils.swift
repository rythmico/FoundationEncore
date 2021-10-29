import Foundation

let locale = Locale(identifier: "en_US_POSIX")
let timeZone = TimeZone(secondsFromGMT: .zero)!
let calendar: Calendar = {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = locale
    calendar.timeZone = timeZone
    return calendar
}()
let dateOnlyFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.calendar = calendar
    return formatter
}()
let timeOnlyFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.calendar = calendar
    return formatter
}()
