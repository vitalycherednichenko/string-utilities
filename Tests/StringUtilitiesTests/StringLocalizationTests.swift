import XCTest
@testable import StringUtilities

final class StringLocalizationTests: XCTestCase {
    
    func testSlugified() {
        XCTAssertEqual("Hello World".slugified(), "hello-world")
        XCTAssertEqual("Привет мир".slugified(), "privet-mir")
        XCTAssertEqual("Hello-World".slugified(), "hello-world")
        XCTAssertEqual("Hello_World".slugified(), "hello-world")
        XCTAssertEqual("Hello World 123".slugified(), "hello-world-123")
        XCTAssertEqual("!@#$%^&*()".slugified(), "")
        XCTAssertEqual("".slugified(), "")
    }
    
    func testTransliterate() {
        XCTAssertEqual("Привет мир".transliterate(), "Privet mir")
        XCTAssertEqual("ПРИВЕТ".transliterate(), "PRIVET")
        XCTAssertEqual("привет".transliterate(), "privet")
        XCTAssertEqual("Съешь ещё этих мягких французских булок".transliterate(),
                      "Syesh esche etikh myagkikh frantsuzskikh bulok")
        XCTAssertEqual("Hello World".transliterate(), "Hello World")
        XCTAssertEqual("Привет123".transliterate(), "Privet123")
        XCTAssertEqual("".transliterate(), "")
    }
    
    func testNormalized() {
        // Комбинированный символ (например, é может быть представлен как e + ´)
        let combinedString = "e\u{0301}" // e + знак ударения
        let normalizedString = combinedString.normalized()
        let singleCharString = "\u{00E9}" // é как один символ
        
        XCTAssertEqual(normalizedString, singleCharString)
        XCTAssertEqual("Hello".normalized(), "Hello")
        XCTAssertEqual("".normalized(), "")
    }
    
    func testEscaping() {
        // HTML-экранирование
        XCTAssertEqual("<div>".escapedForHTML(), "&lt;div&gt;")
        XCTAssertEqual("\"quoted\"".escapedForHTML(), "&quot;quoted&quot;")
        XCTAssertEqual("'quoted'".escapedForHTML(), "&#39;quoted&#39;")
        XCTAssertEqual("a & b".escapedForHTML(), "a &amp; b")
        XCTAssertEqual("Hello World".escapedForHTML(), "Hello World")
        XCTAssertEqual("".escapedForHTML(), "")
        
        // XML-экранирование
        XCTAssertEqual("<tag>".escapedForXML(), "&lt;tag&gt;")
        XCTAssertEqual("\"quoted\"".escapedForXML(), "&quot;quoted&quot;")
        XCTAssertEqual("'quoted'".escapedForXML(), "&apos;quoted&apos;")
        XCTAssertEqual("a & b".escapedForXML(), "a &amp; b")
        XCTAssertEqual("Hello World".escapedForXML(), "Hello World")
        XCTAssertEqual("".escapedForXML(), "")
    }
    
    func testURLCoding() {
        // URL-кодирование
        XCTAssertEqual("Hello World".urlEncoded(), "Hello%20World")
        XCTAssertEqual("a+b=c".urlEncoded(), "a+b%3Dc")
        XCTAssertEqual("Привет мир".urlEncoded(), "%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82%20%D0%BC%D0%B8%D1%80")
        XCTAssertEqual("!@#$%^&*()".urlEncoded(), "!%40%23%24%25%5E%26*()")
        XCTAssertEqual("".urlEncoded(), "")
        
        // URL-декодирование
        XCTAssertEqual("Hello%20World".urlDecoded(), "Hello World")
        XCTAssertEqual("a+b%3Dc".urlDecoded(), "a+b=c")
        XCTAssertEqual("%D0%9F%D1%80%D0%B8%D0%B2%D0%B5%D1%82".urlDecoded(), "Привет")
        XCTAssertEqual("".urlDecoded(), "")
        XCTAssertEqual("Invalid%".urlDecoded(), "Invalid%")
    }
    
    func testCharacterSets() {
        // Проверка на кириллические символы
        XCTAssertTrue("Привет".containsCyrillic())
        XCTAssertTrue("Hello Привет".containsCyrillic())
        XCTAssertFalse("Hello".containsCyrillic())
        XCTAssertFalse("12345".containsCyrillic())
        XCTAssertFalse("".containsCyrillic())
        
        // Проверка на латинские символы
        XCTAssertTrue("Hello".containsLatin())
        XCTAssertTrue("Привет Hello".containsLatin())
        XCTAssertFalse("Привет".containsLatin())
        XCTAssertFalse("12345".containsLatin())
        XCTAssertFalse("".containsLatin())
    }
    
    static var allTests = [
        ("testSlugified", testSlugified),
        ("testTransliterate", testTransliterate),
        ("testNormalized", testNormalized),
        ("testEscaping", testEscaping),
        ("testURLCoding", testURLCoding),
        ("testCharacterSets", testCharacterSets)
    ]
} 