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
        
        var currentOccurrence = 0
        for (offset, character) in self.enumerated() where character == char {
            currentOccurrence += 1
            if currentOccurrence == occurrence {
                return index(startIndex, offsetBy: offset)
            }
        }
        
        return nil
    }
    
    /// Разбивает строку на подстроки указанной длины
    /// - Parameter length: Длина подстрок
    /// - Returns: Массив подстрок
    func chunked(intoGroupsOf length: Int) -> [String] {
        guard length > 0, !isEmpty else { return [self] }
        
        var result: [String] = []
        var currentIndex = startIndex
        
        while currentIndex < endIndex {
            let endIndex = index(currentIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            result.append(String(self[currentIndex..<endIndex]))
            currentIndex = endIndex
        }
        
        return result
    }
    
    /// Разбивает строку на строки указанной длины
    /// - Parameter length: Максимальная длина строки
    /// - Returns: Массив строк, не превышающих указанную длину
    func wordWrapped(toLength length: Int) -> [String] {
        guard length > 0, !isEmpty else { return [self] }
        
        var result: [String] = []
        var currentLine = ""
        
        for word in self.components(separatedBy: " ") {
            if currentLine.isEmpty {
                currentLine = word
            } else if (currentLine + " " + word).count <= length {
                currentLine += " " + word
            } else {
                result.append(currentLine)
                currentLine = word
            }
        }
        
        if !currentLine.isEmpty {
            result.append(currentLine)
        }
        
        return result
    }
    
    /// Получает все вхождения подстроки в строке
    /// - Parameter substring: Искомая подстрока
    /// - Returns: Массив диапазонов вхождений
    func rangesOf(substring: String) -> [Range<String.Index>] {
        guard !substring.isEmpty else { return [] }
        
        var ranges: [Range<String.Index>] = []
        var searchStartIndex = startIndex
        
        while searchStartIndex < endIndex,
              let range = range(of: substring, range: searchStartIndex..<endIndex) {
            ranges.append(range)
            searchStartIndex = range.upperBound
        }
        
        return ranges
    }
    
    /// Получает первые n символов строки
    /// - Parameter n: Количество символов
    /// - Returns: Строка с первыми n символами
    func firstCharacters(_ n: Int) -> String {
        guard n > 0, !isEmpty else { return "" }
        return String(prefix(min(n, count)))
    }
    
    /// Получает последние n символов строки
    /// - Parameter n: Количество символов
    /// - Returns: Строка с последними n символами
    func lastCharacters(_ n: Int) -> String {
        guard n > 0, !isEmpty else { return "" }
        return String(suffix(min(n, count)))
    }
    
    /// Обрезает строку до указанной длины, разделяя на более короткие строки по границам слов
    /// - Parameter maxLength: Максимальная длина строки
    /// - Returns: Строка, разбитая на строки длиной не более maxLength
    func smartTruncate(maxLength: Int) -> String {
        guard maxLength > 0, count > maxLength else { return self }
        
        let words = self.components(separatedBy: " ")
        var result = ""
        var currentLine = ""
        
        for word in words {
            if currentLine.isEmpty {
                currentLine = word
            } else if (currentLine + " " + word).count <= maxLength {
                currentLine += " " + word
            } else {
                result += currentLine + "\n"
                currentLine = word
            }
        }
        
        if !currentLine.isEmpty {
            result += currentLine
        }
        
        return result
    }
    
    /// Получает слова из строки
    /// - Returns: Массив слов
    func words() -> [String] {
        return self.components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
    }
} 