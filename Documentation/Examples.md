# StringUtilities Examples

This document provides practical examples of how to use StringUtilities in real-world scenarios.

## Form Validation

Implementing form validation with StringUtilities:

```swift
struct UserForm {
    let name: String
    let email: String
    let phone: String
    let website: String
    let password: String
    
    enum ValidationError: Error {
        case emptyName
        case invalidEmail
        case invalidPhone
        case invalidWebsite
        case weakPassword
    }
    
    func validate() throws {
        // Name validation
        guard !name.trimmed().isEmpty else {
            throw ValidationError.emptyName
        }
        
        // Email validation
        guard email.isValidEmail() else {
            throw ValidationError.invalidEmail
        }
        
        // Phone validation (10 digits)
        let digitsOnly = phone.replacing(pattern: "\\D", with: "")
        guard digitsOnly.matches(pattern: "^\\d{10}$") else {
            throw ValidationError.invalidPhone
        }
        
        // Website validation
        guard website.isValidURL() else {
            throw ValidationError.invalidWebsite
        }
        
        // Password strength check (example: at least 8 chars with numbers and letters)
        guard password.count >= 8,
              password.matches(pattern: ".*\\d.*"),
              password.matches(pattern: ".*[a-zA-Z].*") else {
            throw ValidationError.weakPassword
        }
    }
}

// Usage:
let form = UserForm(
    name: "John Doe",
    email: "john@example.com",
    phone: "(123) 456-7890",
    website: "https://example.com",
    password: "secureP4ss"
)

do {
    try form.validate()
    print("Form is valid!")
} catch let error as UserForm.ValidationError {
    switch error {
    case .emptyName: print("Name cannot be empty")
    case .invalidEmail: print("Invalid email address")
    case .invalidPhone: print("Invalid phone number")
    case .invalidWebsite: print("Invalid website URL")
    case .weakPassword: print("Password too weak")
    }
}
```

## Text Processing

Working with text content:

```swift
class TextProcessor {
    // Extracts all URLs from text
    static func extractURLs(from text: String) -> [String] {
        // This is a simplified pattern for URLs
        let urlPattern = "https?://[\\w\\d\\-\\.]+\\.[a-zA-Z]{2,}[\\w\\d\\-\\._~:/?#[\\]@!$&'()*+,;=]*"
        return text.extractMatches(pattern: urlPattern)
    }
    
    // Formats a paragraph with line breaks
    static func formatParagraph(_ text: String, maxLineLength: Int = 80) -> String {
        return text.wordWrapped(toLength: maxLineLength).joined(separator: "\n")
    }
    
    // Extracts hashtags from text
    static func extractHashtags(from text: String) -> [String] {
        return text.extractMatches(pattern: "#[\\w\\d]+")
    }
    
    // Censors profanity (simple example)
    static func censorProfanity(_ text: String, badWords: [String]) -> String {
        var result = text
        for word in badWords {
            let pattern = "\\b\(word)\\b"
            let replacement = String(repeating: "*", count: word.count)
            result = result.replacing(pattern: pattern, with: replacement)
        }
        return result
    }
}

// Usage:
let blogPost = """
Check out https://example.com for more info!
This is a long paragraph that should be wrapped to make it more readable on smaller screens.
#programming #swift #tutorial
"""

let urls = TextProcessor.extractURLs(from: blogPost)
print("URLs: \(urls)")

let formatted = TextProcessor.formatParagraph(blogPost)
print("Formatted text:\n\(formatted)")

let hashtags = TextProcessor.extractHashtags(from: blogPost)
print("Hashtags: \(hashtags)")

let censored = TextProcessor.censorProfanity("That darn example is bad.", badWords: ["darn", "bad"])
print("Censored: \(censored)")
```

## Date Handling

Working with dates:

```swift
class DateUtility {
    // Parses dates from various formats
    static func parseDate(_ text: String) -> Date? {
        // Try standard format first
        if let date = text.toDate() {
            return date
        }
        
        // Try alternative formats
        let formats = ["MM/dd/yyyy", "dd.MM.yyyy", "yyyy.MM.dd", "MMMM d, yyyy"]
        
        for format in formats {
            if let date = text.toDate(withFormat: format) {
                return date
            }
        }
        
        return nil
    }
    
    // Formats date for display based on how recent it is
    static func smartDateFormat(_ date: Date) -> String {
        let now = Date()
        let calendar = Calendar.current
        
        // Within last minute
        if now.timeIntervalSince(date) < 60 {
            return "Just now"
        }
        
        // Within today
        if calendar.isDateInToday(date) {
            return date.toRelativeString()
        }
        
        // Yesterday
        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }
        
        // Within last week
        if now.timeIntervalSince(date) < 7 * 24 * 3600 {
            return date.toRelativeString()
        }
        
        // This year
        if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
            return date.toLocalizedString(style: .medium)
        }
        
        // Older
        return date.toLocalizedString(style: .long)
    }
    
    // Extracts dates from text
    static func extractDates(from text: String) -> [Date] {
        // Simple date patterns (could be expanded)
        let patterns = [
            "\\d{4}-\\d{2}-\\d{2}", // yyyy-MM-dd
            "\\d{2}/\\d{2}/\\d{4}", // MM/dd/yyyy or dd/MM/yyyy
            "\\d{2}\\.\\d{2}\\.\\d{4}" // dd.MM.yyyy
        ]
        
        var dates: [Date] = []
        
        for pattern in patterns {
            let matches = text.extractMatches(pattern: pattern)
            for match in matches {
                if let date = parseDate(match) {
                    dates.append(date)
                }
            }
        }
        
        return dates
    }
}

// Usage:
let dateText1 = "2023-04-21"
let dateText2 = "04/21/2023"
let dateText3 = "21.04.2023"

if let date1 = DateUtility.parseDate(dateText1),
   let date2 = DateUtility.parseDate(dateText2),
   let date3 = DateUtility.parseDate(dateText3) {
    print("Date 1: \(date1)")
    print("Date 2: \(date2)")
    print("Date 3: \(date3)")
    
    print("Formatted: \(DateUtility.smartDateFormat(date1))")
}

let text = "Meeting on 2023-04-21 and follow-up on 05/15/2023"
let dates = DateUtility.extractDates(from: text)
print("Found \(dates.count) dates in text")
```

## Data Masking

Implementing data security with masking:

```swift
class DataMasker {
    // Masks credit card number
    static func maskCreditCard(_ cardNumber: String) -> String {
        let digitsOnly = cardNumber.replacing(pattern: "\\D", with: "")
        
        guard digitsOnly.count >= 4 else {
            return digitsOnly.masked(withPattern: String(repeating: "#", count: digitsOnly.count))
        }
        
        // Format: **** **** **** 1234
        let lastFour = String(digitsOnly.suffix(4))
        let maskLength = digitsOnly.count - 4
        let masked = String(repeating: "*", count: maskLength) + lastFour
        
        // Add spaces for readability
        return masked.separated(every: 4, with: " ")
    }
    
    // Masks email address
    static func maskEmail(_ email: String) -> String {
        guard email.isValidEmail() else { return email }
        
        if let atIndex = email.firstIndex(of: "@") {
            let username = String(email[..<atIndex])
            let domain = String(email[atIndex...])
            
            // Show first letter and last letter of username
            if username.count > 2 {
                let firstChar = String(username.prefix(1))
                let lastChar = String(username.suffix(1))
                let maskLength = username.count - 2
                let maskedUsername = firstChar + String(repeating: "*", count: maskLength) + lastChar
                return maskedUsername + domain
            }
            
            return username.masked(withPattern: String(repeating: "#", count: username.count)) + domain
        }
        
        return email
    }
    
    // Masks phone number
    static func maskPhone(_ phone: String) -> String {
        let digitsOnly = phone.replacing(pattern: "\\D", with: "")
        
        guard digitsOnly.count >= 4 else {
            return digitsOnly.masked(withPattern: String(repeating: "#", count: digitsOnly.count))
        }
        
        // Format: (***) ***-1234
        let lastFour = String(digitsOnly.suffix(4))
        let prefixLength = digitsOnly.count - 4
        let maskedPrefix = String(repeating: "*", count: prefixLength)
        
        if digitsOnly.count == 10 {
            // Standard US format
            return "(\(maskedPrefix.prefix(3))) \(maskedPrefix.suffix(3))-\(lastFour)"
        } else {
            // Generic format
            return "\(maskedPrefix)-\(lastFour)"
        }
    }
}

// Usage:
let creditCard = "4111 1111 1111 1111"
let maskedCard = DataMasker.maskCreditCard(creditCard)
print("Masked Card: \(maskedCard)")

let email = "john.doe@example.com"
let maskedEmail = DataMasker.maskEmail(email)
print("Masked Email: \(maskedEmail)")

let phone = "(123) 456-7890"
let maskedPhone = DataMasker.maskPhone(phone)
print("Masked Phone: \(maskedPhone)")
```

---

# Примеры StringUtilities

Этот документ содержит практические примеры использования StringUtilities в реальных сценариях.

## Валидация форм

Реализация валидации формы с помощью StringUtilities:

```swift
struct UserForm {
    let name: String
    let email: String
    let phone: String
    let website: String
    let password: String
    
    enum ValidationError: Error {
        case emptyName
        case invalidEmail
        case invalidPhone
        case invalidWebsite
        case weakPassword
    }
    
    func validate() throws {
        // Проверка имени
        guard !name.trimmed().isEmpty else {
            throw ValidationError.emptyName
        }
        
        // Проверка email
        guard email.isValidEmail() else {
            throw ValidationError.invalidEmail
        }
        
        // Проверка телефона (10 цифр)
        let digitsOnly = phone.replacing(pattern: "\\D", with: "")
        guard digitsOnly.matches(pattern: "^\\d{10}$") else {
            throw ValidationError.invalidPhone
        }
        
        // Проверка веб-сайта
        guard website.isValidURL() else {
            throw ValidationError.invalidWebsite
        }
        
        // Проверка надежности пароля (пример: не менее 8 символов с цифрами и буквами)
        guard password.count >= 8,
              password.matches(pattern: ".*\\d.*"),
              password.matches(pattern: ".*[a-zA-Z].*") else {
            throw ValidationError.weakPassword
        }
    }
}

// Использование:
let form = UserForm(
    name: "Иван Иванов",
    email: "ivan@example.com",
    phone: "(123) 456-7890",
    website: "https://example.com",
    password: "secureP4ss"
)

do {
    try form.validate()
    print("Форма валидна!")
} catch let error as UserForm.ValidationError {
    switch error {
    case .emptyName: print("Имя не может быть пустым")
    case .invalidEmail: print("Некорректный email адрес")
    case .invalidPhone: print("Некорректный номер телефона")
    case .invalidWebsite: print("Некорректный URL веб-сайта")
    case .weakPassword: print("Слишком слабый пароль")
    }
}
```

## Обработка текста

Работа с текстовым содержимым:

```swift
class TextProcessor {
    // Извлекает все URL-адреса из текста
    static func extractURLs(from text: String) -> [String] {
        // Это упрощенный шаблон для URL-адресов
        let urlPattern = "https?://[\\w\\d\\-\\.]+\\.[a-zA-Z]{2,}[\\w\\d\\-\\._~:/?#[\\]@!$&'()*+,;=]*"
        return text.extractMatches(pattern: urlPattern)
    }
    
    // Форматирует абзац с переносами строк
    static func formatParagraph(_ text: String, maxLineLength: Int = 80) -> String {
        return text.wordWrapped(toLength: maxLineLength).joined(separator: "\n")
    }
    
    // Извлекает хэштеги из текста
    static func extractHashtags(from text: String) -> [String] {
        return text.extractMatches(pattern: "#[\\w\\d]+")
    }
    
    // Цензурирует ненормативную лексику (простой пример)
    static func censorProfanity(_ text: String, badWords: [String]) -> String {
        var result = text
        for word in badWords {
            let pattern = "\\b\(word)\\b"
            let replacement = String(repeating: "*", count: word.count)
            result = result.replacing(pattern: pattern, with: replacement)
        }
        return result
    }
}

// Использование:
let blogPost = """
Посетите https://example.com для получения дополнительной информации!
Это длинный абзац, который должен быть разбит, чтобы его было легче читать на экранах меньшего размера.
#программирование #swift #туториал
"""

let urls = TextProcessor.extractURLs(from: blogPost)
print("URL-адреса: \(urls)")

let formatted = TextProcessor.formatParagraph(blogPost)
print("Отформатированный текст:\n\(formatted)")

let hashtags = TextProcessor.extractHashtags(from: blogPost)
print("Хэштеги: \(hashtags)")

let censored = TextProcessor.censorProfanity("Этот чертов пример плохой.", badWords: ["чертов", "плохой"])
print("С цензурой: \(censored)")
```

## Работа с датами

Работа с датами:

```swift
class DateUtility {
    // Разбирает даты из различных форматов
    static func parseDate(_ text: String) -> Date? {
        // Сначала пробуем стандартный формат
        if let date = text.toDate() {
            return date
        }
        
        // Пробуем альтернативные форматы
        let formats = ["MM/dd/yyyy", "dd.MM.yyyy", "yyyy.MM.dd", "d MMMM yyyy"]
        
        for format in formats {
            if let date = text.toDate(withFormat: format) {
                return date
            }
        }
        
        return nil
    }
    
    // Форматирует дату для отображения в зависимости от ее актуальности
    static func smartDateFormat(_ date: Date) -> String {
        let now = Date()
        let calendar = Calendar.current
        
        // В пределах последней минуты
        if now.timeIntervalSince(date) < 60 {
            return "Только что"
        }
        
        // В пределах сегодняшнего дня
        if calendar.isDateInToday(date) {
            return date.toRelativeString()
        }
        
        // Вчера
        if calendar.isDateInYesterday(date) {
            return "Вчера"
        }
        
        // В пределах последней недели
        if now.timeIntervalSince(date) < 7 * 24 * 3600 {
            return date.toRelativeString()
        }
        
        // В этом году
        if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
            return date.toLocalizedString(style: .medium)
        }
        
        // Более старые
        return date.toLocalizedString(style: .long)
    }
    
    // Извлекает даты из текста
    static func extractDates(from text: String) -> [Date] {
        // Простые шаблоны дат (можно расширить)
        let patterns = [
            "\\d{4}-\\d{2}-\\d{2}", // yyyy-MM-dd
            "\\d{2}/\\d{2}/\\d{4}", // MM/dd/yyyy или dd/MM/yyyy
            "\\d{2}\\.\\d{2}\\.\\d{4}" // dd.MM.yyyy
        ]
        
        var dates: [Date] = []
        
        for pattern in patterns {
            let matches = text.extractMatches(pattern: pattern)
            for match in matches {
                if let date = parseDate(match) {
                    dates.append(date)
                }
            }
        }
        
        return dates
    }
}

// Использование:
let dateText1 = "2023-04-21"
let dateText2 = "04/21/2023"
let dateText3 = "21.04.2023"

if let date1 = DateUtility.parseDate(dateText1),
   let date2 = DateUtility.parseDate(dateText2),
   let date3 = DateUtility.parseDate(dateText3) {
    print("Дата 1: \(date1)")
    print("Дата 2: \(date2)")
    print("Дата 3: \(date3)")
    
    print("Отформатировано: \(DateUtility.smartDateFormat(date1))")
}

let text = "Встреча 2023-04-21 и последующие действия 15.05.2023"
let dates = DateUtility.extractDates(from: text)
print("Найдено \(dates.count) дат в тексте")
```

## Маскирование данных

Реализация безопасности данных с помощью маскирования:

```swift
class DataMasker {
    // Маскирует номер кредитной карты
    static func maskCreditCard(_ cardNumber: String) -> String {
        let digitsOnly = cardNumber.replacing(pattern: "\\D", with: "")
        
        guard digitsOnly.count >= 4 else {
            return digitsOnly.masked(withPattern: String(repeating: "#", count: digitsOnly.count))
        }
        
        // Формат: **** **** **** 1234
        let lastFour = String(digitsOnly.suffix(4))
        let maskLength = digitsOnly.count - 4
        let masked = String(repeating: "*", count: maskLength) + lastFour
        
        // Добавляем пробелы для читаемости
        return masked.separated(every: 4, with: " ")
    }
    
    // Маскирует email-адрес
    static func maskEmail(_ email: String) -> String {
        guard email.isValidEmail() else { return email }
        
        if let atIndex = email.firstIndex(of: "@") {
            let username = String(email[..<atIndex])
            let domain = String(email[atIndex...])
            
            // Показывает первую и последнюю букву имени пользователя
            if username.count > 2 {
                let firstChar = String(username.prefix(1))
                let lastChar = String(username.suffix(1))
                let maskLength = username.count - 2
                let maskedUsername = firstChar + String(repeating: "*", count: maskLength) + lastChar
                return maskedUsername + domain
            }
            
            return username.masked(withPattern: String(repeating: "#", count: username.count)) + domain
        }
        
        return email
    }
    
    // Маскирует номер телефона
    static func maskPhone(_ phone: String) -> String {
        let digitsOnly = phone.replacing(pattern: "\\D", with: "")
        
        guard digitsOnly.count >= 4 else {
            return digitsOnly.masked(withPattern: String(repeating: "#", count: digitsOnly.count))
        }
        
        // Формат: (***) ***-1234
        let lastFour = String(digitsOnly.suffix(4))
        let prefixLength = digitsOnly.count - 4
        let maskedPrefix = String(repeating: "*", count: prefixLength)
        
        if digitsOnly.count == 10 {
            // Стандартный формат США
            return "(\(maskedPrefix.prefix(3))) \(maskedPrefix.suffix(3))-\(lastFour)"
        } else {
            // Общий формат
            return "\(maskedPrefix)-\(lastFour)"
        }
    }
}

// Использование:
let creditCard = "4111 1111 1111 1111"
let maskedCard = DataMasker.maskCreditCard(creditCard)
print("Маскированная карта: \(maskedCard)")

let email = "ivan.ivanov@example.com"
let maskedEmail = DataMasker.maskEmail(email)
print("Маскированный Email: \(maskedEmail)")

let phone = "(123) 456-7890"
let maskedPhone = DataMasker.maskPhone(phone)
print("Маскированный телефон: \(maskedPhone)")
``` 