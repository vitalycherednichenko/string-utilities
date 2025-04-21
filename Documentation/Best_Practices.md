# StringUtilities Best Practices

This document provides recommendations and best practices for using the StringUtilities package effectively in your Swift projects.

## Performance Considerations

### Regular Expressions

Regular expressions can be computationally expensive, especially on large strings. To optimize performance:

1. **Avoid unnecessary pattern evaluations**
   ```swift
   // Less efficient - evaluates regex multiple times in a loop
   for item in items {
       if item.matches(pattern: "^\\d+$") {
           // Process numeric items
       }
   }
   
   // More efficient - evaluate once and filter
   let numericItems = items.filter { $0.matches(pattern: "^\\d+$") }
   for item in numericItems {
       // Process numeric items
   }
   ```

2. **Use more specific patterns**
   ```swift
   // Less efficient - broad pattern
   text.matches(pattern: ".*name.*")
   
   // More efficient - specific pattern
   text.matches(pattern: "name")
   ```

### Date Formatting

DateFormatter creation is expensive. StringUtilities internally caches formatters, but be mindful of custom formatters:

```swift
// Internally uses cached formatter
"2023-01-15".toDate()
date.toString()

// For custom formats, formatters are still cached
"2023/01/15".toDate(withFormat: "yyyy/MM/dd")
```

### String Operations on Large Texts

For operations on large text, consider:

1. **Chunking large texts**
   ```swift
   let chunks = largeText.chunked(intoGroupsOf: 1000)
   for chunk in chunks {
       // Process each chunk
   }
   ```

2. **Using word wrapping for formatting**
   ```swift
   let wrappedLines = longText.wordWrapped(toLength: 80)
   ```

## Validation Patterns

### Email Validation

For production applications, consider:

1. **Validation with StringUtilities is good for basic checks**
   ```swift
   if email.isValidEmail() {
       // Basic validation passed
   }
   ```

2. **For critical applications, consider additional verification**
   ```swift
   if email.isValidEmail() {
       // Basic validation passed
       // Consider additional checks like DNS MX record verification
   }
   ```

### Using String Validation in Forms

```swift
// Form validation example
func validateForm(name: String, email: String, phone: String) -> Bool {
    guard !name.trimmed().isEmpty else {
        return false // Name is required
    }
    
    guard email.isValidEmail() else {
        return false // Invalid email
    }
    
    guard phone.matches(pattern: "^\\d{10}$") else {
        return false // Phone should be 10 digits
    }
    
    return true
}
```

## Formatting Best Practices

### Consistent Text Styling

```swift
// For titles
func formatTitle(_ text: String) -> String {
    return text.titlecased()
}

// For content
func formatContent(_ text: String) -> String {
    return text.trimmed().capitalizeFirstLetter()
}
```

### Phone Number Formatting

```swift
func formatPhoneNumber(_ phone: String) -> String {
    // Remove non-digits
    let digits = phone.replacing(pattern: "\\D", with: "")
    
    // Format as XXX-XXX-XXXX
    return digits.separated(every: 3, with: "-")
}
```

### Credit Card Masking

```swift
func maskCreditCard(_ cardNumber: String) -> String {
    // Remove non-digits
    let digits = cardNumber.replacing(pattern: "\\D", with: "")
    
    // Keep last 4 digits visible
    let lastFour = String(digits.suffix(4))
    let maskedPart = String(repeating: "*", count: digits.count - 4)
    
    return maskedPart + lastFour
}

// Alternative using masked method
func maskCreditCard2(_ cardNumber: String) -> String {
    let digits = cardNumber.replacing(pattern: "\\D", with: "")
    let pattern = String(repeating: "#", count: digits.count - 4) + "1234"
    return digits.masked(withPattern: pattern, replacementCharacter: "*")
}
```

## Working with Dates

### Date Presentation

```swift
func formatDateForUser(_ date: Date) -> String {
    let now = Date()
    let calendar = Calendar.current
    
    // If the date is today, show relative time
    if calendar.isDateInToday(date) {
        return date.toRelativeString()
    }
    
    // If the date is this year, show medium date
    if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
        return date.toLocalizedString(style: .medium)
    }
    
    // Otherwise show long date
    return date.toLocalizedString(style: .long)
}
```

### Date Input Validation

```swift
func validateDateInput(_ dateString: String) -> Date? {
    // Try multiple formats
    if let date = dateString.toDate() {
        return date
    }
    
    if let date = dateString.toDate(withFormat: "MM/dd/yyyy") {
        return date
    }
    
    if let date = dateString.toDate(withFormat: "dd.MM.yyyy") {
        return date
    }
    
    return nil
}
```

## Localization Considerations

StringUtilities functions are designed to work with localized content:

```swift
// Date localization is handled automatically
let date = Date()
date.toLocalizedString() // Formats appropriately for user's locale

// For string operations, be mindful of localization
func formatUserInput(_ text: String, locale: Locale) -> String {
    // You might need locale-specific rules for some operations
    // Most StringUtilities functions work well across locales
    return text.trimmed().capitalizeFirstLetter()
}
```

---

# Лучшие практики StringUtilities

Этот документ содержит рекомендации и лучшие практики для эффективного использования пакета StringUtilities в ваших проектах Swift.

## Соображения по производительности

### Регулярные выражения

Регулярные выражения могут быть вычислительно затратными, особенно на больших строках. Для оптимизации производительности:

1. **Избегайте ненужных вычислений шаблонов**
   ```swift
   // Менее эффективно - вычисляет регулярное выражение несколько раз в цикле
   for item in items {
       if item.matches(pattern: "^\\d+$") {
           // Обработка числовых элементов
       }
   }
   
   // Более эффективно - вычисляем один раз и фильтруем
   let numericItems = items.filter { $0.matches(pattern: "^\\d+$") }
   for item in numericItems {
       // Обработка числовых элементов
   }
   ```

2. **Используйте более конкретные шаблоны**
   ```swift
   // Менее эффективно - широкий шаблон
   text.matches(pattern: ".*имя.*")
   
   // Более эффективно - конкретный шаблон
   text.matches(pattern: "имя")
   ```

### Форматирование дат

Создание DateFormatter затратно. StringUtilities внутренне кеширует форматтеры, но учитывайте пользовательские форматтеры:

```swift
// Внутренне использует кешированный форматтер
"2023-01-15".toDate()
date.toString()

// Для пользовательских форматов форматтеры также кешируются
"2023/01/15".toDate(withFormat: "yyyy/MM/dd")
```

### Строковые операции на больших текстах

Для операций с большими текстами:

1. **Разбиение больших текстов на части**
   ```swift
   let chunks = largeText.chunked(intoGroupsOf: 1000)
   for chunk in chunks {
       // Обработка каждой части
   }
   ```

2. **Использование переноса слов для форматирования**
   ```swift
   let wrappedLines = longText.wordWrapped(toLength: 80)
   ```

## Шаблоны валидации

### Валидация Email

Для производственных приложений:

1. **Валидация с помощью StringUtilities хороша для базовых проверок**
   ```swift
   if email.isValidEmail() {
       // Базовая валидация пройдена
   }
   ```

2. **Для критически важных приложений рассмотрите дополнительную проверку**
   ```swift
   if email.isValidEmail() {
       // Базовая валидация пройдена
       // Рассмотрите дополнительные проверки, например, проверку DNS MX-записей
   }
   ```

### Использование валидации строк в формах

```swift
// Пример валидации формы
func validateForm(name: String, email: String, phone: String) -> Bool {
    guard !name.trimmed().isEmpty else {
        return false // Имя обязательно
    }
    
    guard email.isValidEmail() else {
        return false // Неверный email
    }
    
    guard phone.matches(pattern: "^\\d{10}$") else {
        return false // Телефон должен содержать 10 цифр
    }
    
    return true
}
```

## Лучшие практики форматирования

### Последовательное стилевое оформление текста

```swift
// Для заголовков
func formatTitle(_ text: String) -> String {
    return text.titlecased()
}

// Для содержимого
func formatContent(_ text: String) -> String {
    return text.trimmed().capitalizeFirstLetter()
}
```

### Форматирование номера телефона

```swift
func formatPhoneNumber(_ phone: String) -> String {
    // Удаляем нецифровые символы
    let digits = phone.replacing(pattern: "\\D", with: "")
    
    // Форматируем как XXX-XXX-XXXX
    return digits.separated(every: 3, with: "-")
}
```

### Маскирование номера кредитной карты

```swift
func maskCreditCard(_ cardNumber: String) -> String {
    // Удаляем нецифровые символы
    let digits = cardNumber.replacing(pattern: "\\D", with: "")
    
    // Оставляем видимыми последние 4 цифры
    let lastFour = String(digits.suffix(4))
    let maskedPart = String(repeating: "*", count: digits.count - 4)
    
    return maskedPart + lastFour
}

// Альтернатива с использованием метода masked
func maskCreditCard2(_ cardNumber: String) -> String {
    let digits = cardNumber.replacing(pattern: "\\D", with: "")
    let pattern = String(repeating: "#", count: digits.count - 4) + "1234"
    return digits.masked(withPattern: pattern, replacementCharacter: "*")
}
```

## Работа с датами

### Представление дат

```swift
func formatDateForUser(_ date: Date) -> String {
    let now = Date()
    let calendar = Calendar.current
    
    // Если дата - сегодня, показываем относительное время
    if calendar.isDateInToday(date) {
        return date.toRelativeString()
    }
    
    // Если дата в этом году, показываем среднюю дату
    if calendar.component(.year, from: date) == calendar.component(.year, from: now) {
        return date.toLocalizedString(style: .medium)
    }
    
    // В противном случае показываем длинную дату
    return date.toLocalizedString(style: .long)
}
```

### Валидация ввода даты

```swift
func validateDateInput(_ dateString: String) -> Date? {
    // Пробуем несколько форматов
    if let date = dateString.toDate() {
        return date
    }
    
    if let date = dateString.toDate(withFormat: "MM/dd/yyyy") {
        return date
    }
    
    if let date = dateString.toDate(withFormat: "dd.MM.yyyy") {
        return date
    }
    
    return nil
}
```

## Соображения по локализации

Функции StringUtilities предназначены для работы с локализованным контентом:

```swift
// Локализация даты обрабатывается автоматически
let date = Date()
date.toLocalizedString() // Форматирует соответственно локали пользователя

// Для строковых операций учитывайте локализацию
func formatUserInput(_ text: String, locale: Locale) -> String {
    // Для некоторых операций могут потребоваться правила, специфичные для локали
    // Большинство функций StringUtilities хорошо работают в разных локалях
    return text.trimmed().capitalizeFirstLetter()
}
``` 