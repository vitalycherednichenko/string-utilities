import XCTest
@testable import StringUtilities

final class StringFormattingTests: XCTestCase {
    
    func testCapitalizeFirstLetter() {
        XCTAssertEqual("hello".capitalizeFirstLetter(), "Hello")
        XCTAssertEqual("Hello".capitalizeFirstLetter(), "Hello")
        XCTAssertEqual("a".capitalizeFirstLetter(), "A")
        XCTAssertEqual("1abc".capitalizeFirstLetter(), "1abc")
        XCTAssertEqual("".capitalizeFirstLetter(), "")
    }
    
    func testTitlecased() {
        XCTAssertEqual("hello world".titlecased(), "Hello World")
        XCTAssertEqual("HELLO WORLD".titlecased(), "Hello World")
        XCTAssertEqual("hello".titlecased(), "Hello")
        XCTAssertEqual("1st place".titlecased(), "1st Place")
        XCTAssertEqual("".titlecased(), "")
    }
    
    func testTrimmed() {
        XCTAssertEqual("  hello  ".trimmed(), "hello")
        XCTAssertEqual("\nhello\n".trimmed(), "hello")
        XCTAssertEqual("\t hello \t".trimmed(), "hello")
        XCTAssertEqual("hello".trimmed(), "hello")
        XCTAssertEqual("".trimmed(), "")
        XCTAssertEqual(" ".trimmed(), "")
    }
    
    func testRemoveExcessWhitespace() {
        XCTAssertEqual("hello  world".removeExcessWhitespace(), "hello world")
        XCTAssertEqual(" hello   world ".removeExcessWhitespace(), "hello world")
        XCTAssertEqual("hello".removeExcessWhitespace(), "hello")
        XCTAssertEqual("".removeExcessWhitespace(), "")
        XCTAssertEqual("   ".removeExcessWhitespace(), "")
        XCTAssertEqual(" a  b  c ".removeExcessWhitespace(), "a b c")
    }
    
    func testTruncated() {
        XCTAssertEqual("hello world".truncated(toLength: 5), "he...")
        XCTAssertEqual("hello".truncated(toLength: 10), "hello")
        XCTAssertEqual("hello world".truncated(toLength: 8, trailing: "...more"), "h...more")
        XCTAssertEqual("hello world".truncated(toLength: 0), "...")
        XCTAssertEqual("".truncated(toLength: 5), "")
    }
    
    func testSeparated() {
        XCTAssertEqual("1234567890".separated(every: 3, with: "-"), "123-456-789-0")
        XCTAssertEqual("123".separated(every: 4, with: " "), "123")
        XCTAssertEqual("1234".separated(every: 2, with: "-"), "12-34")
        XCTAssertEqual("".separated(every: 3, with: "-"), "")
        XCTAssertEqual("12345".separated(every: 0, with: "-"), "12345")
        XCTAssertEqual("12345".separated(every: 1, with: "-"), "1-2-3-4-5")
    }
    
    func testMasked() {
        XCTAssertEqual("1234567890".masked(withPattern: "#### #### ##", replacementCharacter: "*"), "**** **** **")
        XCTAssertEqual("1234567890".masked(withPattern: "####-####-##"), "****-****-**")
        XCTAssertEqual("123".masked(withPattern: "# # #"), "* * *")
        XCTAssertEqual("12345".masked(withPattern: "##"), "**")
        XCTAssertEqual("".masked(withPattern: "###"), "")
        XCTAssertEqual("1234".masked(withPattern: ""), "")
    }
    
    func testMaskMiddle() {
        XCTAssertEqual("1234567890".maskMiddle(), "1234******7890")
        XCTAssertEqual("1234567890".maskMiddle(visiblePrefix: 2, visibleSuffix: 2), "2******90")
        XCTAssertEqual("1234567890".maskMiddle(visiblePrefix: 0, visibleSuffix: 4), "******7890")
        XCTAssertEqual("1234567890".maskMiddle(visiblePrefix: 5, visibleSuffix: 0), "12345*****")
        XCTAssertEqual("1234567890".maskMiddle(visiblePrefix: 0, visibleSuffix: 0), "**********")
        XCTAssertEqual("123".maskMiddle(visiblePrefix: 2, visibleSuffix: 2), "123")
        XCTAssertEqual("".maskMiddle(), "")
    }
    
    func testCaseConversions() {
        // camelCase to snake_case
        XCTAssertEqual("helloWorld".camelCaseToSnakeCase(), "hello_world")
        XCTAssertEqual("HelloWorld".camelCaseToSnakeCase(), "hello_world")
        XCTAssertEqual("helloWORLD".camelCaseToSnakeCase(), "hello_world")
        XCTAssertEqual("hello".camelCaseToSnakeCase(), "hello")
        XCTAssertEqual("URL".camelCaseToSnakeCase(), "url")
        XCTAssertEqual("PDFDocument".camelCaseToSnakeCase(), "pdf_document")
        XCTAssertEqual("".camelCaseToSnakeCase(), "")
        
        // snake_case to camelCase
        XCTAssertEqual("hello_world".snakeCaseToCamelCase(), "helloWorld")
        XCTAssertEqual("hello_world_test".snakeCaseToCamelCase(), "helloWorldTest")
        XCTAssertEqual("hello".snakeCaseToCamelCase(), "hello")
        XCTAssertEqual("".snakeCaseToCamelCase(), "")
    }
    
    func testReverseWords() {
        XCTAssertEqual("Hello World".reverseWords(), "World Hello")
        XCTAssertEqual("One Two Three".reverseWords(), "Three Two One")
        XCTAssertEqual("Hello".reverseWords(), "Hello")
        XCTAssertEqual("".reverseWords(), "")
        XCTAssertEqual("  Hello  World  ".reverseWords(), "World Hello")
    }
    
    static var allTests = [
        ("testCapitalizeFirstLetter", testCapitalizeFirstLetter),
        ("testTitlecased", testTitlecased),
        ("testTrimmed", testTrimmed),
        ("testRemoveExcessWhitespace", testRemoveExcessWhitespace),
        ("testTruncated", testTruncated),
        ("testSeparated", testSeparated),
        ("testMasked", testMasked),
        ("testMaskMiddle", testMaskMiddle),
        ("testCaseConversions", testCaseConversions),
        ("testReverseWords", testReverseWords)
    ]
} 