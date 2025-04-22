import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(StringValidationTests.allTests),
        testCase(StringFormattingTests.allTests),
        testCase(StringSubstringTests.allTests),
        testCase(StringDateTests.allTests),
        testCase(StringRegexTests.allTests),
        testCase(StringLocalizationTests.allTests),
        testCase(StringTransformTests.allTests)
    ]
}
#endif 