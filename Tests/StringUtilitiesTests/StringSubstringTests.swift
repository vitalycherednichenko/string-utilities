import XCTest
@testable import StringUtilities

final class StringSubstringTests: XCTestCase {
    
    func testSubstringBetween() {
        XCTAssertEqual("hello [world] test".substring(between: "[", and: "]"), "world")
        XCTAssertEqual("<tag>content</tag>".substring(between: "<tag>", and: "</tag>"), "content")
        XCTAssertEqual("prefix-middle-suffix".substring(between: "prefix-", and: "-suffix"), "middle")
        
        XCTAssertNil("hello world".substring(between: "[", and: "]"))
        XCTAssertNil("".substring(between: "[", and: "]"))
        XCTAssertNil("[hello".substring(between: "[", and: "]"))
        XCTAssertNil("hello]".substring(between: "[", and: "]"))
        XCTAssertNil("hello [ world".substring(between: "[", and: "]"))
    }
    
    func testIndexOfNthOccurrence() {
        let testString = "hello hello hello"
        
        let firstH = testString.indexOfNthOccurrence(of: "h" as Character, occurrence: 1)
        XCTAssertNotNil(firstH)
        XCTAssertEqual(testString.distance(from: testString.startIndex, to: firstH!), 0)
        
        let secondH = testString.indexOfNthOccurrence(of: "h" as Character, occurrence: 2)
        XCTAssertNotNil(secondH)
        XCTAssertEqual(testString.distance(from: testString.startIndex, to: secondH!), 6)
        
        let thirdH = testString.indexOfNthOccurrence(of: "h" as Character, occurrence: 3)
        XCTAssertNotNil(thirdH)
        XCTAssertEqual(testString.distance(from: testString.startIndex, to: thirdH!), 12)
        
        let fourthH = testString.indexOfNthOccurrence(of: "h" as Character, occurrence: 4)
        XCTAssertNil(fourthH)
        
        XCTAssertNil(testString.indexOfNthOccurrence(of: "z" as Character, occurrence: 1))
        XCTAssertNil(testString.indexOfNthOccurrence(of: "h" as Character, occurrence: 0))
        XCTAssertNil("".indexOfNthOccurrence(of: "h" as Character, occurrence: 1))
    }
    
    func testChunked() {
        XCTAssertEqual("123456789".chunked(intoGroupsOf: 3), ["123", "456", "789"])
        XCTAssertEqual("12345".chunked(intoGroupsOf: 2), ["12", "34", "5"])
        XCTAssertEqual("123".chunked(intoGroupsOf: 5), ["123"])
        XCTAssertEqual("".chunked(intoGroupsOf: 3), [""])
        XCTAssertEqual("12345".chunked(intoGroupsOf: 0), ["12345"])
        XCTAssertEqual("12345".chunked(intoGroupsOf: 1), ["1", "2", "3", "4", "5"])
    }
    
    func testWordWrapped() {
        XCTAssertEqual("hello world test".wordWrapped(toLength: 10), ["hello", "world test"])
        XCTAssertEqual("hello world test more".wordWrapped(toLength: 10), ["hello", "world test", "more"])
        XCTAssertEqual("hello".wordWrapped(toLength: 10), ["hello"])
        XCTAssertEqual("supercalifragilisticexpialidocious".wordWrapped(toLength: 10), ["supercalifragilisticexpialidocious"])
        XCTAssertEqual("".wordWrapped(toLength: 10), [""])
        XCTAssertEqual("hello world".wordWrapped(toLength: 0), ["hello world"])
    }
    
    func testRangesOf() {
        let text = "hello hello world hello"
        let ranges = text.rangesOf(substring: "hello")
        
        XCTAssertEqual(ranges.count, 3)
        
        XCTAssertEqual(text[ranges[0]], "hello")
        XCTAssertEqual(text.distance(from: text.startIndex, to: ranges[0].lowerBound), 0)
        
        XCTAssertEqual(text[ranges[1]], "hello")
        XCTAssertEqual(text.distance(from: text.startIndex, to: ranges[1].lowerBound), 6)
        
        XCTAssertEqual(text[ranges[2]], "hello")
        XCTAssertEqual(text.distance(from: text.startIndex, to: ranges[2].lowerBound), 18)
        
        let emptyRanges1 = "".rangesOf(substring: "test")
        XCTAssertTrue(emptyRanges1.isEmpty)
        
        let emptyRanges2 = "hello".rangesOf(substring: "test")
        XCTAssertTrue(emptyRanges2.isEmpty)
        
        let emptyRanges3 = "test".rangesOf(substring: "")
        XCTAssertTrue(emptyRanges3.isEmpty)
    }
    
    func testFirstCharacters() {
        XCTAssertEqual("hello world".firstCharacters(5), "hello")
        XCTAssertEqual("hello".firstCharacters(10), "hello")
        XCTAssertEqual("hello".firstCharacters(0), "")
        XCTAssertEqual("".firstCharacters(5), "")
    }
    
    func testLastCharacters() {
        XCTAssertEqual("hello world".lastCharacters(5), "world")
        XCTAssertEqual("hello".lastCharacters(10), "hello")
        XCTAssertEqual("hello".lastCharacters(0), "")
        XCTAssertEqual("".lastCharacters(5), "")
    }
    
    func testSmartTruncate() {
        XCTAssertEqual("hello world test string".smartTruncate(maxLength: 10), "hello\nworld test\nstring")
        XCTAssertEqual("hello".smartTruncate(maxLength: 10), "hello")
        XCTAssertEqual("supercalifragilisticexpialidocious".smartTruncate(maxLength: 10), "supercalifragilisticexpialidocious")
        XCTAssertEqual("hello world".smartTruncate(maxLength: 0), "hello world")
        XCTAssertEqual("".smartTruncate(maxLength: 10), "")
    }
    
    func testWords() {
        XCTAssertEqual("hello world test".words(), ["hello", "world", "test"])
        XCTAssertEqual("hello\nworld\ttest".words(), ["hello", "world", "test"])
        XCTAssertEqual("   hello   world   ".words(), ["hello", "world"])
        XCTAssertEqual("hello".words(), ["hello"])
        
        let emptyResult1 = "".words()
        XCTAssertTrue(emptyResult1.isEmpty)
        
        let emptyResult2 = "   ".words()
        XCTAssertTrue(emptyResult2.isEmpty)
    }
    
    static var allTests = [
        ("testSubstringBetween", testSubstringBetween),
        ("testIndexOfNthOccurrence", testIndexOfNthOccurrence),
        ("testChunked", testChunked),
        ("testWordWrapped", testWordWrapped),
        ("testRangesOf", testRangesOf),
        ("testFirstCharacters", testFirstCharacters),
        ("testLastCharacters", testLastCharacters),
        ("testSmartTruncate", testSmartTruncate),
        ("testWords", testWords)
    ]
} 