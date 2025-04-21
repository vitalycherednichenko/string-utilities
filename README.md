# StringUtilities

A lightweight Swift package providing useful string extension methods for everyday tasks.

[Русская версия документации](#stringutilities-ru)

## Features

- String validation (email, URL, alphanumeric, etc.)
- String formatting and transformation
- Case conversion utilities
- Substring manipulation
- Date-string conversions
- Regular expression operations

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/vitalycherednichenko/stringUtilities.git", from: "1.0.0")
]
```

## Requirements

- Swift 6.1+

## Usage

### Validation

```swift
import StringUtilities

// Email validation
"user@example.com".isValidEmail() // true
"invalid-email".isValidEmail() // false

// URL validation
"https://www.example.com".isValidURL() // true
"example".isValidURL() // false

// Content validation
"123456".isNumeric() // true
"abcDEF".isAlphabetic() // true
"abc123".isAlphanumeric() // true
```

### Formatting

```swift
// Case conversion
"hello".capitalizeFirstLetter() // "Hello"
"hello world".titlecased() // "Hello World"

// Trimming
"  hello  ".trimmed() // "hello"

// Truncating
"hello world".truncated(toLength: 5) // "he..."
"hello world".truncated(toLength: 8, trailing: "...more") // "h...more"

// Adding separators
"1234567890".separated(every: 3, with: "-") // "123-456-789-0"

// Masking
"1234567890".masked(withPattern: "####-####-##") // "****-****-**"
```

### Substring Operations

```swift
// Extracting substrings
"hello [world] test".substring(between: "[", and: "]") // "world"

// Finding nth occurrence
let text = "hello hello hello"
let secondOIndex = text.indexOfNthOccurrence(of: "o", occurrence: 2)

// Chunking
"123456789".chunked(intoGroupsOf: 3) // ["123", "456", "789"]

// Word wrapping
"hello world test".wordWrapped(toLength: 10) // ["hello", "world test"]
```

### Date Operations

```swift
// String to date
let date = "2023-01-15".toDate() // Date representing 2023-01-15

// Date validation
"2023-01-15".isValidDate() // true
"2023-13-45".isValidDate() // false

// Date to string
let date = Date() // Current date
date.toString() // "2023-04-21" (format: yyyy-MM-dd)
date.toRelativeString() // "5 minutes ago"
date.toLocalizedString() // "Apr 21, 2023"
```

### Regular Expression Operations

```swift
// Pattern matching
"12345".matches(pattern: "^\\d+$") // true

// Extracting matches
let text = "The phone numbers are 123-456-7890 and (987) 654-3210"
text.extractMatches(pattern: "\\d{3}[-]\\d{3}[-]\\d{4}") // ["123-456-7890"]

// Extracting capture groups
"The date is 2023-05-15".extractCaptureGroups(pattern: "(\\d{4})-(\\d{2})-(\\d{2})")
// [0: "2023-05-15", 1: "2023", 2: "05", 3: "15"]

// Replacing
"My phone is 123-456-7890".replacing(pattern: "\\d{3}-\\d{3}-\\d{4}", with: "XXX-XXX-XXXX")
// "My phone is XXX-XXX-XXXX"
```

## License

MIT

---

<a name="stringutilities-ru"></a>
# StringUtilities (RU)

Легковесный Swift пакет с полезными расширениями для работы со строками.

## Возможности

- Валидация строк (email, URL, буквенно-цифровые и т.д.)
- Форматирование и преобразование строк
- Утилиты для изменения регистра
- Работа с подстроками
- Преобразование между строками и датами
- Операции с регулярными выражениями

## Установка

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/vitalycherednichenko/stringUtilities.git", from: "1.0.0")
]
```

## Требования

- Swift 6.1+

## Использование

### Валидация

```swift
import StringUtilities

// Проверка email
"user@example.com".isValidEmail() // true
"invalid-email".isValidEmail() // false

// Проверка URL
"https://www.example.com".isValidURL() // true
"example".isValidURL() // false

// Проверка содержимого
"123456".isNumeric() // true - содержит только цифры
"abcDEF".isAlphabetic() // true - содержит только буквы
"abc123".isAlphanumeric() // true - содержит только буквы и цифры
```

### Форматирование

```swift
// Изменение регистра
"hello".capitalizeFirstLetter() // "Hello"
"hello world".titlecased() // "Hello World"

// Обрезка пробелов
"  hello  ".trimmed() // "hello"

// Усечение строки
"hello world".truncated(toLength: 5) // "he..."
"hello world".truncated(toLength: 8, trailing: "...more") // "h...more"

// Добавление разделителей
"1234567890".separated(every: 3, with: "-") // "123-456-789-0"

// Маскирование
"1234567890".masked(withPattern: "####-####-##") // "****-****-**"
```

### Операции с подстроками

```swift
// Извлечение подстрок
"hello [world] test".substring(between: "[", and: "]") // "world"

// Поиск n-го вхождения
let text = "hello hello hello"
let secondOIndex = text.indexOfNthOccurrence(of: "o", occurrence: 2)

// Разбиение на части
"123456789".chunked(intoGroupsOf: 3) // ["123", "456", "789"]

// Перенос слов
"hello world test".wordWrapped(toLength: 10) // ["hello", "world test"]
```

### Операции с датами

```swift
// Строка в дату
let date = "2023-01-15".toDate() // Дата, представляющая 2023-01-15

// Проверка даты
"2023-01-15".isValidDate() // true
"2023-13-45".isValidDate() // false

// Дата в строку
let date = Date() // Текущая дата
date.toString() // "2023-04-21" (формат: yyyy-MM-dd)
date.toRelativeString() // "5 минут назад"
date.toLocalizedString() // "21 апр. 2023 г."
```

### Операции с регулярными выражениями

```swift
// Проверка соответствия шаблону
"12345".matches(pattern: "^\\d+$") // true

// Извлечение совпадений
let text = "Телефонные номера: 123-456-7890 и (987) 654-3210"
text.extractMatches(pattern: "\\d{3}[-]\\d{3}[-]\\d{4}") // ["123-456-7890"]

// Извлечение групп захвата
"Дата: 2023-05-15".extractCaptureGroups(pattern: "(\\d{4})-(\\d{2})-(\\d{2})")
// [0: "2023-05-15", 1: "2023", 2: "05", 3: "15"]

// Замена
"Мой телефон: 123-456-7890".replacing(pattern: "\\d{3}-\\d{3}-\\d{4}", with: "XXX-XXX-XXXX")
// "Мой телефон: XXX-XXX-XXXX"
```

## Лицензия

MIT 