# Справочник API StringUtilities

Этот документ содержит подробную информацию обо всех доступных методах в пакете StringUtilities.

## Содержание

1. [Валидация строк](#валидация-строк)
2. [Форматирование строк](#форматирование-строк)
3. [Операции с подстроками](#операции-с-подстроками)
4. [Операции с датами](#операции-с-датами)
5. [Операции с регулярными выражениями](#операции-с-регулярными-выражениями)

## Валидация строк

### isValidEmail()

Проверяет, является ли строка валидным email-адресом.

```swift
func isValidEmail() -> Bool
```

**Возвращает**: `true`, если строка является валидным email-адресом, иначе `false`.

**Пример**:
```swift
"user@example.com".isValidEmail() // true
"invalid-email".isValidEmail() // false
```

### isValidURL()

Проверяет, является ли строка валидным URL.

```swift
func isValidURL() -> Bool
```

**Возвращает**: `true`, если строка является валидным URL с схемой и хостом, иначе `false`.

**Пример**:
```swift
"https://www.example.com".isValidURL() // true
"example.com".isValidURL() // false
```

### isNumeric()

Проверяет, содержит ли строка только цифры.

```swift
func isNumeric() -> Bool
```

**Возвращает**: `true`, если строка содержит только цифры и не пуста, иначе `false`.

**Пример**:
```swift
"123456".isNumeric() // true
"123abc".isNumeric() // false
```

### isAlphabetic()

Проверяет, содержит ли строка только буквы.

```swift
func isAlphabetic() -> Bool
```

**Возвращает**: `true`, если строка содержит только буквы и не пуста, иначе `false`.

**Пример**:
```swift
"abcDEF".isAlphabetic() // true
"abc123".isAlphabetic() // false
```

### isAlphanumeric()

Проверяет, содержит ли строка только буквы и цифры.

```swift
func isAlphanumeric() -> Bool
```

**Возвращает**: `true`, если строка содержит только буквы и цифры и не пуста, иначе `false`.

**Пример**:
```swift
"abc123".isAlphanumeric() // true
"abc123!".isAlphanumeric() // false
```

## Форматирование строк

### capitalizeFirstLetter()

Переводит первую букву строки в верхний регистр.

```swift
func capitalizeFirstLetter() -> String
```

**Возвращает**: Строку с первой буквой в верхнем регистре.

**Пример**:
```swift
"hello".capitalizeFirstLetter() // "Hello"
"hello world".capitalizeFirstLetter() // "Hello world"
```

### titlecased()

Переводит первую букву каждого слова в строке в верхний регистр.

```swift
func titlecased() -> String
```

**Возвращает**: Строку с первой буквой каждого слова в верхнем регистре.

**Пример**:
```swift
"hello world".titlecased() // "Hello World"
"HELLO WORLD".titlecased() // "Hello World"
```

### trimmed()

Удаляет начальные и конечные пробелы и переносы строк.

```swift
func trimmed() -> String
```

**Возвращает**: Строку без начальных и конечных пробелов и переносов строк.

**Пример**:
```swift
"  hello  ".trimmed() // "hello"
"\nhello\n".trimmed() // "hello"
```

### truncated(toLength:trailing:)

Обрезает строку до указанной длины и добавляет окончание, если необходимо.

```swift
func truncated(toLength length: Int, trailing: String = "...") -> String
```

**Параметры**:
- `length`: Максимальная длина результирующей строки, включая строку окончания.
- `trailing`: Строка, добавляемая при обрезке (по умолчанию: "...").

**Возвращает**: Обрезанную строку, если она длиннее указанной длины, или исходную строку, если короче.

**Пример**:
```swift
"hello world".truncated(toLength: 5) // "he..."
"hello".truncated(toLength: 10) // "hello"
"hello world".truncated(toLength: 8, trailing: "...more") // "h...more"
```

### separated(every:with:)

Вставляет символ-разделитель через указанные интервалы в строке.

```swift
func separated(every stride: Int, with separator: Character) -> String
```

**Параметры**:
- `stride`: Интервал, через который вставляются разделители.
- `separator`: Символ для вставки в качестве разделителя.

**Возвращает**: Строку с разделителями, вставленными через указанные интервалы.

**Пример**:
```swift
"1234567890".separated(every: 3, with: "-") // "123-456-789-0"
"123".separated(every: 4, with: " ") // "123"
```

### masked(withPattern:replacementCharacter:)

Маскирует строку в соответствии с указанным шаблоном.

```swift
func masked(withPattern pattern: String, replacementCharacter: Character = "*") -> String
```

**Параметры**:
- `pattern`: Шаблон, где символы "#" будут заменены символом замены.
- `replacementCharacter`: Символ для маскирования (по умолчанию: "*").

**Возвращает**: Маскированную строку в соответствии с указанным шаблоном.

**Пример**:
```swift
"1234567890".masked(withPattern: "####-####-##") // "****-****-**"
"1234567890".masked(withPattern: "#### #### ##", replacementCharacter: "X") // "XXXX XXXX XX"
```

## Операции с подстроками

### substring(between:and:)

Получает подстроку между двумя указанными строками.

```swift
func substring(between start: String, and end: String) -> String?
```

**Параметры**:
- `start`: Начальная строка.
- `end`: Конечная строка.

**Возвращает**: Подстроку между указанными строками или `nil`, если одна из строк не найдена.

**Пример**:
```swift
"hello [world] test".substring(between: "[", and: "]") // "world"
"hello world".substring(between: "[", and: "]") // nil
```

### indexOfNthOccurrence(of:occurrence:)

Находит индекс n-ного вхождения символа в строке.

```swift
func indexOfNthOccurrence(of char: Character, occurrence: Int) -> Index?
```

**Параметры**:
- `char`: Символ для поиска.
- `occurrence`: Номер вхождения (начиная с 1).

**Возвращает**: Индекс n-ного вхождения символа или `nil`, если не найдено.

**Пример**:
```swift
let text = "hello world"
let secondOIndex = text.indexOfNthOccurrence(of: "o", occurrence: 2)
// Индекс второго "o" в "hello world"
```

### chunked(intoGroupsOf:)

Разбивает строку на части указанной длины.

```swift
func chunked(intoGroupsOf length: Int) -> [String]
```

**Параметры**:
- `length`: Длина каждой части.

**Возвращает**: Массив строковых частей.

**Пример**:
```swift
"123456789".chunked(intoGroupsOf: 3) // ["123", "456", "789"]
"12345".chunked(intoGroupsOf: 2) // ["12", "34", "5"]
```

### wordWrapped(toLength:)

Разбивает строку на строки, не превышающие указанную длину, сохраняя целостность слов.

```swift
func wordWrapped(toLength length: Int) -> [String]
```

**Параметры**:
- `length`: Максимальная длина каждой строки.

**Возвращает**: Массив строк, каждая из которых не превышает указанную длину.

**Пример**:
```swift
"hello world test".wordWrapped(toLength: 10) // ["hello", "world test"]
```

## Операции с датами

### String.toDate(withFormat:)

Преобразует строку в дату, используя указанный формат.

```swift
func toDate(withFormat format: String = "yyyy-MM-dd") -> Date?
```

**Параметры**:
- `format`: Строка формата даты (по умолчанию: "yyyy-MM-dd").

**Возвращает**: Объект `Date` или `nil`, если строка не является валидной датой.

**Пример**:
```swift
"2023-01-15".toDate() // Дата, представляющая 15 января 2023 года
"2023-01-15".toDate(withFormat: "yyyy-MM-dd") // То же самое
```

### String.isValidDate(withFormat:)

Проверяет, содержит ли строка валидную дату в указанном формате.

```swift
func isValidDate(withFormat format: String = "yyyy-MM-dd") -> Bool
```

**Параметры**:
- `format`: Строка формата даты (по умолчанию: "yyyy-MM-dd").

**Возвращает**: `true`, если строка содержит валидную дату, иначе `false`.

**Пример**:
```swift
"2023-01-15".isValidDate() // true
"2023-13-45".isValidDate() // false
```

### Date.toString(withFormat:)

Преобразует дату в строку, используя указанный формат.

```swift
func toString(withFormat format: String = "yyyy-MM-dd") -> String
```

**Параметры**:
- `format`: Строка формата даты (по умолчанию: "yyyy-MM-dd").

**Возвращает**: Строковое представление даты.

**Пример**:
```swift
let date = Date() // Текущая дата
date.toString() // например, "2023-04-21"
date.toString(withFormat: "dd.MM.yyyy") // например, "21.04.2023"
```

### Date.toRelativeString()

Возвращает относительное описание времени (например, "5 минут назад").

```swift
func toRelativeString() -> String
```

**Возвращает**: Относительное описание времени относительно текущей даты.

**Пример**:
```swift
let fiveMinutesAgo = Date(timeIntervalSinceNow: -300)
fiveMinutesAgo.toRelativeString() // "5 минут назад"
```

### Date.toLocalizedString(style:)

Возвращает локализованное строковое представление даты.

```swift
func toLocalizedString(style: DateFormatter.Style = .medium) -> String
```

**Параметры**:
- `style`: Стиль форматирования даты (по умолчанию: .medium).

**Возвращает**: Локализованное строковое представление даты.

**Пример**:
```swift
let date = Date() // Текущая дата
date.toLocalizedString() // например, "21 апр. 2023 г."
date.toLocalizedString(style: .long) // например, "21 апреля 2023 г."
```

## Операции с регулярными выражениями

### matches(pattern:)

Проверяет, соответствует ли строка шаблону регулярного выражения.

```swift
func matches(pattern: String) -> Bool
```

**Параметры**:
- `pattern`: Шаблон регулярного выражения.

**Возвращает**: `true`, если строка соответствует шаблону, иначе `false`.

**Пример**:
```swift
"12345".matches(pattern: "^\\d+$") // true
"12345a".matches(pattern: "^\\d+$") // false
```

### extractMatches(pattern:)

Извлекает все совпадения с шаблоном регулярного выражения из строки.

```swift
func extractMatches(pattern: String) -> [String]
```

**Параметры**:
- `pattern`: Шаблон регулярного выражения.

**Возвращает**: Массив строк, соответствующих шаблону.

**Пример**:
```swift
let text = "Телефонные номера: 123-456-7890 и (987) 654-3210"
text.extractMatches(pattern: "\\d{3}[-]\\d{3}[-]\\d{4}")
// ["123-456-7890"]
```

### extractCaptureGroups(pattern:)

Извлекает группы захвата из совпадения с регулярным выражением.

```swift
func extractCaptureGroups(pattern: String) -> [Int: String]
```

**Параметры**:
- `pattern`: Шаблон регулярного выражения с группами захвата.

**Возвращает**: Словарь, где ключи - индексы групп захвата, а значения - захваченные строки.

**Пример**:
```swift
"Дата: 2023-05-15".extractCaptureGroups(pattern: "(\\d{4})-(\\d{2})-(\\d{2})")
// [0: "2023-05-15", 1: "2023", 2: "05", 3: "15"]
```

### replacing(pattern:with:)

Заменяет все вхождения шаблона регулярного выражения строкой замены.

```swift
func replacing(pattern: String, with replacement: String) -> String
```

**Параметры**:
- `pattern`: Шаблон регулярного выражения для замены.
- `replacement`: Строка замены.

**Возвращает**: Строку со всеми совпадениями с шаблоном, замененными на строку замены.

**Пример**:
```swift
"Мой телефон: 123-456-7890".replacing(pattern: "\\d{3}-\\d{3}-\\d{4}", with: "XXX-XXX-XXXX")
// "Мой телефон: XXX-XXX-XXXX"
```

## Тестирование

Библиотека StringUtilities имеет полное покрытие тестами. Тесты организованы по функциональным группам:

- **StringTransformTests**: базовые преобразования строк (переворот, изменение регистра, обрезка)
- **StringFormattingTests**: форматирование строк (первая буква заглавная, titlecase, обрезка пробелов, удаление лишних пробелов)
- **StringSubstringTests**: работа с подстроками (получение части строки, поиск подстрок)
- **StringRegexTests**: работа с регулярными выражениями
- **StringDateTests**: конвертация между датой и строкой
- **StringValidationTests**: методы валидации (проверка email, URL и т.д.)
- **StringLocalizationTests**: локализация, транслитерация, экранирование

Для запуска тестов:

```bash
swift test
```

## Форматирование кода и стиль

Код в библиотеке StringUtilities отформатирован согласно стандартным правилам форматирования Swift:

1. Используйте 4 пробела для отступов
2. Открывающие скобки на той же строке
3. Максимальная длина строки 100 символов
4. Все публичные API имеют документацию
5. Используйте camelCase для методов и свойств

## Дополнительные методы

### Преобразование между camelCase и snake_case

```swift
"helloWorld".camelCaseToSnakeCase() // Возвращает "hello_world"
"hello_world".snakeCaseToCamelCase() // Возвращает "helloWorld"
```

### Изменение порядка слов

```swift
"Hello World".reverseWords() // Возвращает "World Hello"
```

### Экранирование HTML и XML

```swift
"<div>".escapedForHTML() // Возвращает "&lt;div&gt;"
"<tag>".escapedForXML() // Возвращает "&lt;tag&gt;"
```

### Проверка наличия специфических символов

```swift
"Привет".containsCyrillic() // Возвращает true
"Hello".containsLatin() // Возвращает true
```

### Транслитерация

```swift
"Привет".transliterate() // Возвращает "Privet"
```

### URL-кодирование и декодирование

```swift
"Hello World".urlEncoded() // Возвращает "Hello%20World"
"Hello%20World".urlDecoded() // Возвращает "Hello World"
```

### Создание слагов для URL

```swift
"Hello World".slugified() // Возвращает "hello-world"
```

### Нормализация

```swift
let combinedE = "e\u{0301}" // e + знак ударения
combinedE.normalized() // Возвращает "\u{00E9}" (é как один символ)
``` 