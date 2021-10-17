extension TimeZone {
    public static var neutral: Self {
        TimeZone(secondsFromGMT: .zero) !! preconditionFailure("TimeZone.init(secondsFromGMT: .zero) returned nil")
    }
}
