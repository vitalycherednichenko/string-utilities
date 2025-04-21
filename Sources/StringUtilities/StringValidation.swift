import Foundation

public extension String {
    
    /// Проверяет, является ли строка валидным email-адресом
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return matches(pattern: emailRegEx)
    }
    
    /// Проверяет, является ли строка валидным URL
    func isValidURL() -> Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme != nil && url.host != nil
    }
    
    /// Проверяет, содержит ли строка только цифры
    func isNumeric() -> Bool {
        return !isEmpty && matches(pattern: "^\\d+$")
    }
    
    /// Проверяет, содержит ли строка только буквы
    func isAlphabetic() -> Bool {
        return !isEmpty && matches(pattern: "^[a-zA-Z]+$")
    }
    
    /// Проверяет, содержит ли строка только буквы и цифры
    func isAlphanumeric() -> Bool {
        return !isEmpty && matches(pattern: "^[a-zA-Z0-9]+$")
    }
} 