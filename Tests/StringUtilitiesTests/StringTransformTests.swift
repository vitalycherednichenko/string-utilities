import XCTest
@testable import StringUtilities

final class StringTransformTests: XCTestCase {
    
    func testReverse() {
        XCTAssertEqual(String("hello".reversed()), "olleh")
        XCTAssertEqual(String("Hello, World!".reversed()), "!dlroW ,olleH")
        XCTAssertEqual(String("".reversed()), "")
        XCTAssertEqual(String("a".reversed()), "a")
    }
    
    func testCapitalized() {
        XCTAssertEqual("hello".capitalized, "Hello")
        XCTAssertEqual("hello world".capitalized, "Hello World")
        XCTAssertEqual("HELLO".capitalized, "Hello")
        XCTAssertEqual("".capitalized, "")
    }
    
    func testUppercased() {
        XCTAssertEqual("hello".uppercased(), "HELLO")
        XCTAssertEqual("Hello World".uppercased(), "HELLO WORLD")
        XCTAssertEqual("".uppercased(), "")
    }
    
    func testLowercased() {
        XCTAssertEqual("HELLO".lowercased(), "hello")
        XCTAssertEqual("Hello World".lowercased(), "hello world")
        XCTAssertEqual("".lowercased(), "")
    }
    
    func testTrimmedWhitespace() {
        XCTAssertEqual("  hello  ".trimmed(), "hello")
        XCTAssertEqual("\n\thello\n\t".trimmed(), "hello")
        XCTAssertEqual("hello".trimmed(), "hello")
        XCTAssertEqual("".trimmed(), "")
    }
    
    func testCamelToSnake() {
        XCTAssertEqual("helloWorld".camelCaseToSnakeCase(), "hello_world")
        XCTAssertEqual("HelloWorld".camelCaseToSnakeCase(), "hello_world")
        XCTAssertEqual("PDFDocument".camelCaseToSnakeCase(), "pdf_document")
        XCTAssertEqual("".camelCaseToSnakeCase(), "")
    }
    
    func testSnakeToCamel() {
        XCTAssertEqual("hello_world".snakeCaseToCamelCase(), "helloWorld")
        XCTAssertEqual("test_string_here".snakeCaseToCamelCase(), "testStringHere")
        XCTAssertEqual("single".snakeCaseToCamelCase(), "single")
        XCTAssertEqual("".snakeCaseToCamelCase(), "")
    }
    
    func testSeparatedGroups() {
        XCTAssertEqual("1234567890".separated(every: 3, with: "-"), "123-456-789-0")
        XCTAssertEqual("1234567".separated(every: 2, with: "_"), "12_34_56_7")
        XCTAssertEqual("123".separated(every: 5, with: "-"), "123")
        XCTAssertEqual("".separated(every: 3, with: "-"), "")
    }
    
    func testMasked() {
        XCTAssertEqual("1234567890".masked(withPattern: "#### #### ##", replacementCharacter: "#"), "#### #### ##")
        XCTAssertEqual("ABC123".masked(withPattern: "XX-XXX", replacementCharacter: "X"), "XX-XXX")
        XCTAssertEqual("".masked(withPattern: "###"), "")
    }
    
    static var allTests = [
        ("testReverse", testReverse),
        ("testCapitalized", testCapitalized),
        ("testUppercased", testUppercased),
        ("testLowercased", testLowercased),
        ("testTrimmedWhitespace", testTrimmedWhitespace),
        ("testCamelToSnake", testCamelToSnake),
        ("testSnakeToCamel", testSnakeToCamel),
        ("testSeparatedGroups", testSeparatedGroups),
        ("testMasked", testMasked)
    ]
} 