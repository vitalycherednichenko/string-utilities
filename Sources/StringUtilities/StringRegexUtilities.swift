import Foundation

public extension String {
    
    /// Создает NSRegularExpression из строкового шаблона
    /// - Parameter pattern: Шаблон регулярного выражения
    /// - Returns: NSRegularExpression или nil, если шаблон некорректен
    private func regex(for pattern: String) -> NSRegularExpression? {
        return try? NSRegularExpression(pattern: pattern)
    }
    
    /// Возвращает NSRange для всей строки
    private var fullRange: NSRange {
        return NSRange(location: 0, length: self.utf16.count)
    }
    
    /// Проверяет, соответствует ли строка указанному регулярному выражению
    /// - Parameter pattern: Шаблон регулярного выражения
    /// - Returns: true если соответствует
    func matches(pattern: String) -> Bool {
        guard let regex = regex(for: pattern) else { return false }
        return regex.firstMatch(in: self, options: [], range: fullRange) != nil
    }
    
    /// Извлекает все совпадения с регулярным выражением
    /// - Parameter pattern: Шаблон регулярного выражения
    /// - Returns: Массив найденных строк
    func extractMatches(pattern: String) -> [String] {
        guard let regex = regex(for: pattern) else { return [] }
        
        let nsrange = NSRange(self.startIndex..., in: self)
        let results = regex.matches(in: self, range: nsrange)
        
        return results.compactMap { match in
            guard let range = Range(match.range, in: self) else { return nil }
            return String(self[range])
        }
    }
    
    /// Извлекает совпадения с группами захвата в регулярном выражении
    /// - Parameter pattern: Шаблон регулярного выражения
    /// - Returns: Словарь с группами захвата (ключ - номер группы, значение - подстрока)
    func extractCaptureGroups(pattern: String) -> [Int: String] {
        guard let regex = regex(for: pattern) else { return [:] }
        
        let nsrange = NSRange(self.startIndex..., in: self)
        guard let match = regex.firstMatch(in: self, range: nsrange) else {
            return [:]
        }
        
        return (0..<match.numberOfRanges).reduce(into: [Int: String]()) { result, i in
            guard let range = Range(match.range(at: i), in: self) else { return }
            result[i] = String(self[range])
        }
    }
    
    /// Заменяет все совпадения с регулярным выражением указанной строкой
    /// - Parameters:
    ///   - pattern: Шаблон регулярного выражения
    ///   - replacement: Строка замены
    /// - Returns: Строка с примененными заменами
    func replacing(pattern: String, with replacement: String) -> String {
        guard let regex = regex(for: pattern) else { return self }
        return regex.stringByReplacingMatches(in: self, options: [], 
                                              range: fullRange, 
                                              withTemplate: replacement)
    }
} 