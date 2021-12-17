extension StringProtocol {
    public func trimmingLineCharacters(in set: CharacterSet) -> String {
        self.split(separator: .newline)
            .map { $0.trimmingCharacters(in: set) }
            .joined(separator: .newline)
    }
}
