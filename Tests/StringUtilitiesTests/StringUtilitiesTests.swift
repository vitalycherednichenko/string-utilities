import XCTest
@testable import StringUtilities

final class StringUtilitiesTests: XCTestCase {
    
    // MARK: - Validation Tests
    
    func testEmailValidation() {
        XCTAssertTrue("test@example.com".isValidEmail())
        XCTAssertTrue("john.doe123@gmail.com".isValidEmail())
        XCTAssertFalse("invalid-email".isValidEmail())
        XCTAssertFalse("@example.com".isValidEmail())
        XCTAssertFalse("test@".isValidEmail())
    }
    
    func testURLValidation() {
        XCTAssertTrue("https://www.example.com".isValidURL())
        XCTAssertTrue("http://example.com/path".isValidURL())
        XCTAssertFalse("example".isValidURL())
        XCTAssertFalse("http://".isValidURL())
    }
    
    func testNumericValidation() {
        XCTAssertTrue("123456".isNumeric())
        XCTAssertFalse("123abc".isNumeric())
        XCTAssertFalse("".isNumeric())
    }
    
    func testAlphabeticValidation() {
        XCTAssertTrue("abcDEF".isAlphabetic())
        XCTAssertFalse("abc123".isAlphabetic())
        XCTAssertFalse("".isAlphabetic())
    }
    
    func testAlphanumericValidation() {
        XCTAssertTrue("abc123".isAlphanumeric())
        XCTAssertFalse("abc123!".isAlphanumeric())
        XCTAssertFalse("".isAlphanumeric())
    }
    
    // MARK: - Formatting Tests
    
    func testCapitalizeFirstLetter() {
        XCTAssertEqual("hello".capitalizeFirstLetter(), "Hello")
        XCTAssertEqual("Hello".capitalizeFirstLetter(), "Hello")
        XCTAssertEqual("".capitalizeFirstLetter(), "")
    }
    
    func testTitlecased() {
        XCTAssertEqual("hello world".titlecased(), "Hello World")
        XCTAssertEqual("HELLO WORLD".titlecased(), "Hello World")
        XCTAssertEqual("".titlecased(), "")
    }
    
    func testTrimmed() {
        XCTAssertEqual("  hello  ".trimmed(), "hello")
        XCTAssertEqual("\nhello\n".trimmed(), "hello")
        XCTAssertEqual("hello".trimmed(), "hello")
    }
    
    func testTruncated() {
        XCTAssertEqual("hello world".truncated(toLength: 5), "he...")
        XCTAssertEqual("hello".truncated(toLength: 10), "hello")
        XCTAssertEqual("hello world".truncated(toLength: 8, trailing: "...more"), "h...more")
    }
    
    func testSeparated() {
        XCTAssertEqual("1234567890".separated(every: 3, with: "-"), "123-456-789-0")
        XCTAssertEqual("123".separated(every: 4, with: " "), "123")
    }
    
    // MARK: - Substring Tests
    
    func testSubstringBetween() {
        XCTAssertEqual("hello [world] test".substring(between: "[", and: "]"), "world")
        XCTAssertNil("hello world".substring(between: "[", and: "]"))
    }
    
    func testChunked() {
        XCTAssertEqual("123456789".chunked(intoGroupsOf: 3), ["123", "456", "789"])
        XCTAssertEqual("12345".chunked(intoGroupsOf: 2), ["12", "34", "5"])
        XCTAssertEqual("123".chunked(intoGroupsOf: 5), ["123"])
    }
    
    func testWordWrapped() {
        XCTAssertEqual("hello world test".wordWrapped(toLength: 10), ["hello", "world test"])
        XCTAssertEqual("supercalifragilisticexpialidocious".wordWrapped(toLength: 10), ["supercalifragilisticexpialidocious"])
    }
    
    // MARK: - Date Tests
    
    func testToDate() {
        let dateString = "2023-01-15"
        let date = dateString.toDate()
        XCTAssertNotNil(date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 15)
    }
    
    func testIsValidDate() {
        XCTAssertTrue("2023-01-15".isValidDate())
        XCTAssertFalse("2023-13-45".isValidDate())
        XCTAssertFalse("invalid-date".isValidDate())
    }
    
    func testDateToString() {
        let components = DateComponents(year: 2023, month: 1, day: 15)
        let date = Calendar.current.date(from: components)!
        XCTAssertEqual(date.toString(), "2023-01-15")
    }
    
    // MARK: - Regex Tests
    
    func testMatches() {
        XCTAssertTrue("12345".matches(pattern: "^\\d+$"))
        XCTAssertFalse("12345a".matches(pattern: "^\\d+$"))
    }
    
    func testExtractMatches() {
        let input = "The phone numbers are 123-456-7890 and (987) 654-3210"
        let result = input.extractMatches(pattern: "\\d{3}[-]\\d{3}[-]\\d{4}|\\(\\d{3}\\) \\d{3}-\\d{4}")
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], "123-456-7890")
        XCTAssertEqual(result[1], "(987) 654-3210")
    }
    
    func testExtractCaptureGroups() {
        let input = "The date is 2023-05-15"
        let result = input.extractCaptureGroups(pattern: "(\\d{4})-(\\d{2})-(\\d{2})")
        XCTAssertEqual(result[0], "2023-05-15")
        XCTAssertEqual(result[1], "2023")
        XCTAssertEqual(result[2], "05")
        XCTAssertEqual(result[3], "15")
    }
    
    func testReplacing() {
        let input = "My phone number is 123-456-7890"
        let result = input.replacing(pattern: "\\d{3}-\\d{3}-\\d{4}", with: "XXX-XXX-XXXX")
        XCTAssertEqual(result, "My phone number is XXX-XXX-XXXX")
    }
    
    // MARK: - Additional Tests for Untested Functions
    
    func testMasked() {
        XCTAssertEqual("1234567890".masked(withPattern: "#### #### ##", replacementCharacter: "*"), "**** **** **")
        XCTAssertEqual("1234567890".masked(withPattern: "####-####-##"), "****-****-**")
        XCTAssertEqual("123".masked(withPattern: "# # #"), "* * *")
    }
    
    func testIndexOfNthOccurrence() {
        let testString = "hello hello hello"
        
        let firstO = testString.indexOfNthOccurrence(of: "o" as Character, occurrence: 1)
        XCTAssertNotNil(firstO)
        XCTAssertEqual(testString.distance(from: testString.startIndex, to: firstO!), 4)
        
        let secondO = testString.indexOfNthOccurrence(of: "o" as Character, occurrence: 2)
        XCTAssertNotNil(secondO)
        XCTAssertEqual(testString.distance(from: testString.startIndex, to: secondO!), 10)
        
        let thirdO = testString.indexOfNthOccurrence(of: "o" as Character, occurrence: 3)
        XCTAssertNotNil(thirdO)
        XCTAssertEqual(testString.distance(from: testString.startIndex, to: thirdO!), 16)
        
        let fourthO = testString.indexOfNthOccurrence(of: "o" as Character, occurrence: 4)
        XCTAssertNil(fourthO)
        
        XCTAssertNil(testString.indexOfNthOccurrence(of: "z" as Character, occurrence: 1))
        XCTAssertNil(testString.indexOfNthOccurrence(of: "o" as Character, occurrence: 0))
    }
    
    func testDateToRelativeString() {
        let currentDate = Date()
        let oneHourAgo = Calendar.current.date(byAdding: .hour, value: -1, to: currentDate)!
        let relativeDateString = oneHourAgo.toRelativeString()
        
        // Проверяем, что строка содержит слово "час" (может быть на разных языках)
        XCTAssertTrue(relativeDateString.contains("час") || 
                      relativeDateString.contains("hour") || 
                      relativeDateString.lowercased().contains("назад") || 
                      relativeDateString.contains("ago"))
    }
    
    func testDateToLocalizedString() {
        let date = Date(timeIntervalSince1970: 0) // 1 января 1970
        let localizedString = date.toLocalizedString()
        XCTAssertTrue(localizedString.contains("1970") || localizedString.contains("70"))
        
        let shortStyle = date.toLocalizedString(style: .short)
        let mediumStyle = date.toLocalizedString(style: .medium)
        let longStyle = date.toLocalizedString(style: .long)
        
        XCTAssertNotEqual(shortStyle, mediumStyle)
        XCTAssertNotEqual(mediumStyle, longStyle)
    }
}

extension StringUtilitiesTests {
    static var allTests = [
        ("testEmailValidation", testEmailValidation),
        ("testURLValidation", testURLValidation),
        ("testNumericValidation", testNumericValidation),
        ("testAlphabeticValidation", testAlphabeticValidation),
        ("testAlphanumericValidation", testAlphanumericValidation),
        ("testCapitalizeFirstLetter", testCapitalizeFirstLetter),
        ("testTitlecased", testTitlecased),
        ("testTrimmed", testTrimmed),
        ("testTruncated", testTruncated),
        ("testSeparated", testSeparated),
        ("testSubstringBetween", testSubstringBetween),
        ("testChunked", testChunked),
        ("testWordWrapped", testWordWrapped),
        ("testToDate", testToDate),
        ("testIsValidDate", testIsValidDate),
        ("testDateToString", testDateToString),
        ("testMatches", testMatches),
        ("testExtractMatches", testExtractMatches),
        ("testExtractCaptureGroups", testExtractCaptureGroups),
        ("testReplacing", testReplacing),
        ("testMasked", testMasked),
        ("testIndexOfNthOccurrence", testIndexOfNthOccurrence),
        ("testDateToRelativeString", testDateToRelativeString),
        ("testDateToLocalizedString", testDateToLocalizedString)
    ]
}
