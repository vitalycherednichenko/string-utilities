import Foundation

public extension String {
    
    /// Получает подстроку между двумя указанными строками
    /// - Parameters:
    ///   - start: Начальная строка
    ///   - end: Конечная строка
    /// - Returns: Подстрока или nil, если не найдено
    func substring(between start: String, and end: String) -> String? {
        guard let startRange = range(of: start),
              let endRange = range(of: end, range: startRange.upperBound..<endIndex)
        else { return nil }
        
        return String(self[startRange.upperBound..<endRange.lowerBound])
    }
    
    /// Получает n-ное вхождение символа в строке
    /// - Parameters:
    ///   - char: Искомый символ
    ///   - occurrence: Номер вхождения (начиная с 1)
    /// - Returns: Индекс n-ного вхождения или nil, если не найдено
    func indexOfNthOccurrence(of char: Character, occurrence: Int) -> Index? {
        guard occurrence > 0 else { return nil }
        
        return enumerated()
            .filter { $0.element == char }
            .dropFirst(occurrence - 1)
            .first
            .map { index(startIndex, offsetBy: $0.offset) }
    }
    
    /// Разбивает строку на подстроки указанной длины
    /// - Parameter length: Длина подстрок
    /// - Returns: Массив подстрок
    func chunked(intoGroupsOf length: Int) -> [String] {
        guard length > 0, !isEmpty else { return [self] }
        
        return stride(from: 0, to: count, by: length).map {
            let start = index(startIndex, offsetBy: $0, limitedBy: endIndex) ?? endIndex
            let end = index(start, offsetBy: length, limitedBy: endIndex) ?? endIndex
            return String(self[start..<end])
        }
    }
    
    /// Разбивает строку на строки указанной длины
    /// - Parameter length: Максимальная длина строки
    /// - Returns: Массив строк, не превышающих указанную длину
    func wordWrapped(toLength length: Int) -> [String] {
        guard length > 0 else { return [self] }
        
        return components(separatedBy: " ").reduce(into: [String]()) { lines, word in
            if let lastLine = lines.last, (lastLine + " " + word).count <= length {
                lines[lines.count - 1] = lastLine + " " + word
            } else {
                lines.append(word)
            }
        }
    }
} 