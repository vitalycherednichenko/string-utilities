import XCTest
@testable import StringUtilities

final class StringValidationTests: XCTestCase {
    
    func testIsEmail() {
        XCTAssertTrue("test@example.com".isEmail())
        XCTAssertTrue("user.name+tag@domain.co.uk".isEmail())
        XCTAssertTrue("firstname.lastname@domain.com".isEmail())
        
        XCTAssertFalse("".isEmail())
        XCTAssertFalse("invalid@".isEmail())
        XCTAssertFalse("@domain.com".isEmail())
        XCTAssertFalse("plaintext".isEmail())
        XCTAssertFalse("user@domain".isEmail())
    }
    
    func testIsValidUrl() {
        XCTAssertTrue("https://www.example.com".isValidUrl())
        XCTAssertTrue("http://example.com/path".isValidUrl())
        XCTAssertTrue("http://subdomain.example.co.uk/path?query=test".isValidUrl())
        
        XCTAssertFalse("".isValidUrl())
        XCTAssertFalse("example.com".isValidUrl())
        XCTAssertFalse("www.example.com".isValidUrl())
        XCTAssertFalse("ftp://example.com".isValidUrl()) // Only supports http and https
    }
    
    func testIsNumeric() {
        XCTAssertTrue("123".isNumeric())
        XCTAssertTrue("0".isNumeric())
        XCTAssertTrue("123456789".isNumeric())
        
        XCTAssertFalse("".isNumeric())
        XCTAssertFalse("123a".isNumeric())
        XCTAssertFalse("a123".isNumeric())
        XCTAssertFalse("12.3".isNumeric())
        XCTAssertFalse("-123".isNumeric())
    }
    
    func testIsAlphabetic() {
        XCTAssertTrue("abc".isAlphabetic())
        XCTAssertTrue("ABC".isAlphabetic())
        XCTAssertTrue("abcDEF".isAlphabetic())
        
        XCTAssertFalse("".isAlphabetic())
        XCTAssertFalse("abc123".isAlphabetic())
        XCTAssertFalse("abc def".isAlphabetic())
        XCTAssertFalse("abc-def".isAlphabetic())
    }
    
    func testIsAlphanumeric() {
        XCTAssertTrue("abc123".isAlphanumeric())
        XCTAssertTrue("123abc".isAlphanumeric())
        XCTAssertTrue("abc".isAlphanumeric())
        XCTAssertTrue("123".isAlphanumeric())
        
        XCTAssertFalse("".isAlphanumeric())
        XCTAssertFalse("abc 123".isAlphanumeric())
        XCTAssertFalse("abc-123".isAlphanumeric())
        XCTAssertFalse("abc_123".isAlphanumeric())
    }
    
    func testContainsOnlyDigits() {
        XCTAssertTrue("123".containsOnlyDigits())
        XCTAssertTrue("0".containsOnlyDigits())
        XCTAssertTrue("123456789".containsOnlyDigits())
        
        XCTAssertFalse("".containsOnlyDigits())
        XCTAssertFalse("123a".containsOnlyDigits())
        XCTAssertFalse("a123".containsOnlyDigits())
        XCTAssertFalse("12.3".containsOnlyDigits())
        XCTAssertFalse("-123".containsOnlyDigits())
    }
    
    func testIsValidPassword() {
        XCTAssertTrue("Abc123!".isValidPassword())
        XCTAssertTrue("ComplexP@ssw0rd".isValidPassword())
        XCTAssertTrue("P@ssw0rd".isValidPassword())
        
        XCTAssertFalse("".isValidPassword())
        XCTAssertFalse("short".isValidPassword())
        XCTAssertFalse("onlylowercase".isValidPassword())
        XCTAssertFalse("ONLYUPPERCASE".isValidPassword())
        XCTAssertFalse("12345678".isValidPassword())
        XCTAssertFalse("NoSpecialChar123".isValidPassword())
        XCTAssertFalse("NoDigitsHere!".isValidPassword())
    }
    
    func testHasOnlyLetters() {
        XCTAssertTrue("abc".hasOnlyLetters())
        XCTAssertTrue("ABC".hasOnlyLetters())
        XCTAssertTrue("AbCdEf".hasOnlyLetters())
        
        XCTAssertFalse("".hasOnlyLetters())
        XCTAssertFalse("abc123".hasOnlyLetters())
        XCTAssertFalse("abc def".hasOnlyLetters())
    }
    
    func testIsBlank() {
        XCTAssertTrue("".isBlank())
        XCTAssertTrue("   ".isBlank())
        XCTAssertTrue("\t\n".isBlank())
        
        XCTAssertFalse("a".isBlank())
        XCTAssertFalse(" a ".isBlank())
        XCTAssertFalse(" \t a \n ".isBlank())
    }
    
    static var allTests = [
        ("testIsEmail", testIsEmail),
        ("testIsValidUrl", testIsValidUrl),
        ("testIsNumeric", testIsNumeric),
        ("testIsAlphabetic", testIsAlphabetic),
        ("testIsAlphanumeric", testIsAlphanumeric),
        ("testContainsOnlyDigits", testContainsOnlyDigits),
        ("testIsValidPassword", testIsValidPassword),
        ("testHasOnlyLetters", testHasOnlyLetters),
        ("testIsBlank", testIsBlank)
    ]
} 