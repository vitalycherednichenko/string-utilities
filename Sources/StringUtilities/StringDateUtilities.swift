import Foundation

// Утилита для кеширования форматтеров дат
private class DateFormatterCache {
    static let shared = DateFormatterCache()
    private var formatters = [String: DateFormatter]()
    private let lock = NSLock()
    
    private init() {}
    
    func formatter(for format: String) -> DateFormatter {
        lock.lock()
        defer { lock.unlock() }
        
        if let formatter = formatters[format] {
            return formatter
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatters[format] = formatter
        return formatter
    }
}

public extension String {
    
    /// Конвертирует строку в дату, используя указанный формат
    /// - Parameter format: Формат даты (по умолчанию "yyyy-MM-dd")
    /// - Returns: Optional Date объект
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatterCache.shared.formatter(for: format)
        return formatter.date(from: self)
    }
    
    /// Проверяет, содержит ли строка валидную дату в указанном формате
    /// - Parameter format: Формат даты (по умолчанию "yyyy-MM-dd")
    /// - Returns: true если строка содержит валидную дату
    func isValidDate(withFormat format: String = "yyyy-MM-dd") -> Bool {
        return toDate(withFormat: format) != nil
    }
}

public extension Date {
    
    /// Конвертирует дату в строку с указанным форматом
    /// - Parameter format: Формат даты (по умолчанию "yyyy-MM-dd")
    /// - Returns: Строковое представление даты
    func toString(withFormat format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatterCache.shared.formatter(for: format)
        return formatter.string(from: self)
    }
    
    /// Возвращает строку с относительным описанием времени (например, "5 минут назад")
    func toRelativeString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    /// Возвращает строку с датой в локализованном формате
    /// - Parameter style: Стиль форматирования даты
    /// - Returns: Локализованное строковое представление даты
    func toLocalizedString(style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
} 