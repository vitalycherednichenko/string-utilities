# StringUtilities API Reference

This document provides detailed information about all the available methods in the StringUtilities package.

## Table of Contents

1. [String Validation](#string-validation)
2. [String Formatting](#string-formatting)
3. [Substring Operations](#substring-operations)
4. [Date Operations](#date-operations)
5. [Regular Expression Operations](#regular-expression-operations)

## String Validation

### isValidEmail()

Checks if a string is a valid email address.

```swift
func isValidEmail() -> Bool
```

**Returns**: `true` if the string is a valid email address, `false` otherwise.

**Example**:
```swift
"user@example.com".isValidEmail() // true
"invalid-email".isValidEmail() // false
```

### isValidURL()

Checks if a string is a valid URL.

```swift
func isValidURL() -> Bool
```

**Returns**: `true` if the string is a valid URL with scheme and host, `false` otherwise.

**Example**:
```swift
"https://www.example.com".isValidURL() // true
"example.com".isValidURL() // false
```

### isNumeric()

Checks if a string contains only numeric characters.

```swift
func isNumeric() -> Bool
```

**Returns**: `true` if the string contains only digits and is not empty, `false` otherwise.

**Example**:
```swift
"123456".isNumeric() // true
"123abc".isNumeric() // false
```

### isAlphabetic()

Checks if a string contains only alphabetic characters.

```swift
func isAlphabetic() -> Bool
```

**Returns**: `true` if the string contains only letters and is not empty, `false` otherwise.

**Example**:
```swift
"abcDEF".isAlphabetic() // true
"abc123".isAlphabetic() // false
```

### isAlphanumeric()

Checks if a string contains only alphanumeric characters.

```swift
func isAlphanumeric() -> Bool
```

**Returns**: `true` if the string contains only letters and digits and is not empty, `false` otherwise.

**Example**:
```swift
"abc123".isAlphanumeric() // true
"abc123!".isAlphanumeric() // false
```

## String Formatting

### capitalizeFirstLetter()

Capitalizes the first letter of a string.

```swift
func capitalizeFirstLetter() -> String
```

**Returns**: A string with the first letter capitalized.

**Example**:
```swift
"hello".capitalizeFirstLetter() // "Hello"
"hello world".capitalizeFirstLetter() // "Hello world"
```

### titlecased()

Capitalizes the first letter of each word in a string.

```swift
func titlecased() -> String
```

**Returns**: A string with the first letter of each word capitalized.

**Example**:
```swift
"hello world".titlecased() // "Hello World"
"HELLO WORLD".titlecased() // "Hello World"
```

### trimmed()

Removes leading and trailing whitespace and newlines from a string.

```swift
func trimmed() -> String
```

**Returns**: A string with leading and trailing whitespace and newlines removed.

**Example**:
```swift
"  hello  ".trimmed() // "hello"
"\nhello\n".trimmed() // "hello"
```

### truncated(toLength:trailing:)

Truncates a string to the specified length and adds a trailing string if necessary.

```swift
func truncated(toLength length: Int, trailing: String = "...") -> String
```

**Parameters**:
- `length`: The maximum length of the resulting string including the trailing string.
- `trailing`: The string to append if truncation is necessary (default: "...").

**Returns**: A truncated string if longer than the specified length, or the original string if shorter.

**Example**:
```swift
"hello world".truncated(toLength: 5) // "he..."
"hello".truncated(toLength: 10) // "hello"
"hello world".truncated(toLength: 8, trailing: "...more") // "h...more"
```

### separated(every:with:)

Inserts a separator character at specified intervals in a string.

```swift
func separated(every stride: Int, with separator: Character) -> String
```

**Parameters**:
- `stride`: The interval at which to insert separators.
- `separator`: The character to insert as a separator.

**Returns**: A string with separators inserted at the specified intervals.

**Example**:
```swift
"1234567890".separated(every: 3, with: "-") // "123-456-789-0"
"123".separated(every: 4, with: " ") // "123"
```

### masked(withPattern:replacementCharacter:)

Masks a string according to a specified pattern.

```swift
func masked(withPattern pattern: String, replacementCharacter: Character = "*") -> String
```

**Parameters**:
- `pattern`: A pattern where "#" characters will be replaced by the replacement character.
- `replacementCharacter`: The character to use for masking (default: "*").

**Returns**: A masked string according to the specified pattern.

**Example**:
```swift
"1234567890".masked(withPattern: "####-####-##") // "****-****-**"
"1234567890".masked(withPattern: "#### #### ##", replacementCharacter: "X") // "XXXX XXXX XX"
```

## Substring Operations

### substring(between:and:)

Gets a substring between two specified strings.

```swift
func substring(between start: String, and end: String) -> String?
```

**Parameters**:
- `start`: The starting string.
- `end`: The ending string.

**Returns**: The substring between the specified strings, or `nil` if either string is not found.

**Example**:
```swift
"hello [world] test".substring(between: "[", and: "]") // "world"
"hello world".substring(between: "[", and: "]") // nil
```

### indexOfNthOccurrence(of:occurrence:)

Finds the index of the nth occurrence of a character in a string.

```swift
func indexOfNthOccurrence(of char: Character, occurrence: Int) -> Index?
```

**Parameters**:
- `char`: The character to search for.
- `occurrence`: The occurrence number to find (starting from 1).

**Returns**: The index of the nth occurrence of the character, or `nil` if not found.

**Example**:
```swift
let text = "hello world"
let secondOIndex = text.indexOfNthOccurrence(of: "o", occurrence: 2)
// Index of the second "o" in "hello world"
```

### chunked(intoGroupsOf:)

Splits a string into chunks of the specified length.

```swift
func chunked(intoGroupsOf length: Int) -> [String]
```

**Parameters**:
- `length`: The length of each chunk.

**Returns**: An array of string chunks.

**Example**:
```swift
"123456789".chunked(intoGroupsOf: 3) // ["123", "456", "789"]
"12345".chunked(intoGroupsOf: 2) // ["12", "34", "5"]
```

### wordWrapped(toLength:)

Splits a string into lines not exceeding the specified length, preserving whole words.

```swift
func wordWrapped(toLength length: Int) -> [String]
```

**Parameters**:
- `length`: The maximum length of each line.

**Returns**: An array of strings, each not exceeding the specified length.

**Example**:
```swift
"hello world test".wordWrapped(toLength: 10) // ["hello", "world test"]
```

## Date Operations

### String.toDate(withFormat:)

Converts a string to a date using the specified format.

```swift
func toDate(withFormat format: String = "yyyy-MM-dd") -> Date?
```

**Parameters**:
- `format`: The date format string (default: "yyyy-MM-dd").

**Returns**: A `Date` object, or `nil` if the string is not a valid date.

**Example**:
```swift
"2023-01-15".toDate() // Date representing January 15, 2023
"2023-01-15".toDate(withFormat: "yyyy-MM-dd") // Same as above
```

### String.isValidDate(withFormat:)

Checks if a string contains a valid date in the specified format.

```swift
func isValidDate(withFormat format: String = "yyyy-MM-dd") -> Bool
```

**Parameters**:
- `format`: The date format string (default: "yyyy-MM-dd").

**Returns**: `true` if the string contains a valid date, `false` otherwise.

**Example**:
```swift
"2023-01-15".isValidDate() // true
"2023-13-45".isValidDate() // false
```

### Date.toString(withFormat:)

Converts a date to a string using the specified format.

```swift
func toString(withFormat format: String = "yyyy-MM-dd") -> String
```

**Parameters**:
- `format`: The date format string (default: "yyyy-MM-dd").

**Returns**: A string representation of the date.

**Example**:
```swift
let date = Date() // Current date
date.toString() // e.g., "2023-04-21"
date.toString(withFormat: "MM/dd/yyyy") // e.g., "04/21/2023"
```

### Date.toRelativeString()

Returns a relative description of the time (e.g., "5 minutes ago").

```swift
func toRelativeString() -> String
```

**Returns**: A relative description of the time compared to the current date.

**Example**:
```swift
let fiveMinutesAgo = Date(timeIntervalSinceNow: -300)
fiveMinutesAgo.toRelativeString() // "5 minutes ago"
```

### Date.toLocalizedString(style:)

Returns a localized string representation of the date.

```swift
func toLocalizedString(style: DateFormatter.Style = .medium) -> String
```

**Parameters**:
- `style`: The date formatting style (default: .medium).

**Returns**: A localized string representation of the date.

**Example**:
```swift
let date = Date() // Current date
date.toLocalizedString() // e.g., "Apr 21, 2023"
date.toLocalizedString(style: .long) // e.g., "April 21, 2023"
```

## Regular Expression Operations

### matches(pattern:)

Checks if a string matches a regular expression pattern.

```swift
func matches(pattern: String) -> Bool
```

**Parameters**:
- `pattern`: The regular expression pattern.

**Returns**: `true` if the string matches the pattern, `false` otherwise.

**Example**:
```swift
"12345".matches(pattern: "^\\d+$") // true
"12345a".matches(pattern: "^\\d+$") // false
```

### extractMatches(pattern:)

Extracts all matches of a regular expression pattern from a string.

```swift
func extractMatches(pattern: String) -> [String]
```

**Parameters**:
- `pattern`: The regular expression pattern.

**Returns**: An array of matching strings.

**Example**:
```swift
let text = "The phone numbers are 123-456-7890 and (987) 654-3210"
text.extractMatches(pattern: "\\d{3}[-]\\d{3}[-]\\d{4}")
// ["123-456-7890"]
```

### extractCaptureGroups(pattern:)

Extracts capture groups from a regular expression match.

```swift
func extractCaptureGroups(pattern: String) -> [Int: String]
```

**Parameters**:
- `pattern`: The regular expression pattern with capture groups.

**Returns**: A dictionary where keys are capture group indices and values are the captured strings.

**Example**:
```swift
"The date is 2023-05-15".extractCaptureGroups(pattern: "(\\d{4})-(\\d{2})-(\\d{2})")
// [0: "2023-05-15", 1: "2023", 2: "05", 3: "15"]
```

### replacing(pattern:with:)

Replaces all occurrences of a regular expression pattern with a replacement string.

```swift
func replacing(pattern: String, with replacement: String) -> String
```

**Parameters**:
- `pattern`: The regular expression pattern to replace.
- `replacement`: The replacement string.

**Returns**: A string with all pattern matches replaced.

**Example**:
```swift
"My phone is 123-456-7890".replacing(pattern: "\\d{3}-\\d{3}-\\d{4}", with: "XXX-XXX-XXXX")
// "My phone is XXX-XXX-XXXX"
``` 