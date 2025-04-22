import XCTest
@testable import StringUtilities

final class StringRegexTests: XCTestCase {
    
    func testMatches() {
        XCTAssertTrue("12345".matches(pattern: "^\\d+$"))
        XCTAssertTrue("hello".matches(pattern: "^[a-z]+$"))
        XCTAssertTrue("Hello 123".matches(pattern: "^[A-Za-z]+ \\d+$"))
        
        XCTAssertFalse("12345a".matches(pattern: "^\\d+$"))
        XCTAssertFalse("Hello".matches(pattern: "^[a-z]+$"))
        XCTAssertFalse("".matches(pattern: "^[a-z]+$"))
        
        // Проверка на обработку ошибок
        XCTAssertFalse("12345".matches(pattern: "["))
    }
    
    func testExtractMatches() {
        let input = "The phone numbers are 123-456-7890 and (987) 654-3210"
        let result = input.extractMatches(pattern: "\\d{3}[-]\\d{3}[-]\\d{4}|\\(\\d{3}\\) \\d{3}-\\d{4}")
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0], "123-456-7890")
        XCTAssertEqual(result[1], "(987) 654-3210")
        
        XCTAssertEqual("hello".extractMatches(pattern: "\\d+"), [])
        XCTAssertEqual("".extractMatches(pattern: "\\d+"), [])
        
        // Проверка на обработку ошибок
        XCTAssertEqual("12345".extractMatches(pattern: "["), [])
    }
    
    func testExtractCaptureGroups() {
        let input = "The date is 2023-05-15"
        let result = input.extractCaptureGroups(pattern: "(\\d{4})-(\\d{2})-(\\d{2})")
        XCTAssertEqual(result[0], "2023-05-15")
        XCTAssertEqual(result[1], "2023")
        XCTAssertEqual(result[2], "05")
        XCTAssertEqual(result[3], "15")
        
        let emptyResult1 = "hello".extractCaptureGroups(pattern: "(\\d+)")
        XCTAssertTrue(emptyResult1.isEmpty)
        
        let emptyResult2 = "".extractCaptureGroups(pattern: "(\\d+)")
        XCTAssertTrue(emptyResult2.isEmpty)
        
        // Проверка на обработку ошибок
        let emptyResult3 = "12345".extractCaptureGroups(pattern: "[")
        XCTAssertTrue(emptyResult3.isEmpty)
    }
    
    func testReplacing() {
        let input = "My phone number is 123-456-7890"
        let result = input.replacing(pattern: "\\d{3}-\\d{3}-\\d{4}", with: "XXX-XXX-XXXX")
        XCTAssertEqual(result, "My phone number is XXX-XXX-XXXX")
        
        // Множественная замена
        let input2 = "Numbers: 123, 456, 789"
        let result2 = input2.replacing(pattern: "\\d+", with: "X")
        XCTAssertEqual(result2, "Numbers: X, X, X")
        
        // Строка без совпадений
        XCTAssertEqual("hello".replacing(pattern: "\\d+", with: "X"), "hello")
        
        // Пустая строка
        XCTAssertEqual("".replacing(pattern: "\\d+", with: "X"), "")
        
        // Проверка на обработку ошибок
        XCTAssertEqual("12345".replacing(pattern: "[", with: "X"), "12345")
    }
    
    func testReplacingFirst() {
        let input = "Numbers: 123, 456, 789"
        let result = input.replacingFirst(pattern: "\\d+", with: "X")
        XCTAssertEqual(result, "Numbers: X, 456, 789")
        
        // Строка без совпадений
        XCTAssertEqual("hello".replacingFirst(pattern: "\\d+", with: "X"), "hello")
        
        // Пустая строка
        XCTAssertEqual("".replacingFirst(pattern: "\\d+", with: "X"), "")
        
        // Проверка на обработку ошибок
        XCTAssertEqual("12345".replacingFirst(pattern: "[", with: "X"), "12345")
    }
    
    func testContainsString() {
        // Проверка с учетом регистра
        XCTAssertTrue("Hello World".containsString("Hello"))
        XCTAssertFalse("Hello World".containsString("hello"))
        
        // Проверка без учета регистра
        XCTAssertTrue("Hello World".containsString("hello", caseSensitive: false))
        
        // Пустые строки
        XCTAssertFalse("".containsString("hello"))
        XCTAssertTrue("hello".containsString(""))
    }
    
    static var allTests = [
        ("testMatches", testMatches),
        ("testExtractMatches", testExtractMatches),
        ("testExtractCaptureGroups", testExtractCaptureGroups),
        ("testReplacing", testReplacing),
        ("testReplacingFirst", testReplacingFirst),
        ("testContainsString", testContainsString)
    ]
} 