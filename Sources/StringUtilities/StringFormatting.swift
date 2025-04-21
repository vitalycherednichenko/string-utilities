import Foundation

public extension String {
    
    /// Переводит первую букву строки в верхний регистр
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    /// Переводит первую букву каждого слова в строке в верхний регистр
    func titlecased() -> String {
        return self.lowercased().components(separatedBy: " ")
            .map { $0.capitalizeFirstLetter() }
            .joined(separator: " ")
    }
    
    /// Удаляет лишние пробелы из строки
    func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Обрезает строку до указанной длины и добавляет многоточие, если строка длиннее
    func truncated(toLength length: Int, trailing: String = "...") -> String {
        if self.count > length {
            let end = length - trailing.count
            guard end > 0 else { return trailing }
            return String(self.prefix(end)) + trailing
        } else {
            return self
        }
    }
    
    /// Вставляет разделители в строку через указанный интервал (удобно для форматирования номеров)
    func separated(every stride: Int, with separator: Character) -> String {
        guard stride > 0, !isEmpty else { return self }
        
        return enumerated()
            .map { $0.offset > 0 && $0.offset % stride == 0 ? "\(separator)\($0.element)" : String($0.element) }
            .joined()
    }
    
    /// Маскирует символы в строке (например, для номеров карт)
    func masked(withPattern pattern: String, replacementCharacter: Character = "*") -> String {
        var result = ""
        var patternIndex = pattern.startIndex
        var stringIndex = self.startIndex
        
        while patternIndex < pattern.endIndex && stringIndex < self.endIndex {
            let patternChar = pattern[patternIndex]
            
            if patternChar == "#" {
                result.append(replacementCharacter)
                stringIndex = self.index(after: stringIndex)
            } else {
                result.append(patternChar)
            }
            
            patternIndex = pattern.index(after: patternIndex)
        }
        
        return result
    }
} 