import XCTest
@testable import StringUtilities

final class StringDateTests: XCTestCase {
    
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
    
    func testToDateWithCustomFormat() {
        let dateString = "15/01/2023"
        let date = dateString.toDate(withFormat: "dd/MM/yyyy")
        XCTAssertNotNil(date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 15)
    }
    
    func testToDateWithLocale() {
        let dateString = "janvier 15, 2023"
        let frenchLocale = Locale(identifier: "fr_FR")
        let date = dateString.toDate(withFormat: "MMMM dd, yyyy", locale: frenchLocale)
        XCTAssertNotNil(date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 15)
    }
    
    func testIsValidDate() {
        XCTAssertTrue("2023-01-15".isValidDate())
        XCTAssertTrue("2020-02-29".isValidDate()) // Високосный год
        
        XCTAssertFalse("2023-13-45".isValidDate())
        XCTAssertFalse("invalid-date".isValidDate())
        XCTAssertFalse("2023/01/15".isValidDate())
    }
    
    func testDateToString() {
        let components = DateComponents(year: 2023, month: 1, day: 15)
        let date = Calendar.current.date(from: components)!
        XCTAssertEqual(date.toString(), "2023-01-15")
    }
    
    func testDateToStringWithCustomFormat() {
        let components = DateComponents(year: 2023, month: 1, day: 15)
        let date = Calendar.current.date(from: components)!
        XCTAssertEqual(date.toString(withFormat: "dd/MM/yyyy"), "15/01/2023")
    }
    
    func testDateToRelativeString() {
        let now = Date()
        let oneHourAgo = Calendar.current.date(byAdding: .hour, value: -1, to: now)!
        let relativeDateString = oneHourAgo.toRelativeString()
        
        // Проверка может зависеть от локализации пользователя
        XCTAssertTrue(relativeDateString.contains("час") || 
                     relativeDateString.contains("hour") || 
                     relativeDateString.contains("1") || 
                     relativeDateString.contains("один"))
    }
    
    func testDateToLocalizedString() {
        let date = Date(timeIntervalSince1970: 0) // 1 января 1970
        let localizedString = date.toLocalizedString()
        XCTAssertTrue(localizedString.contains("1970") || 
                     localizedString.contains("70"))
        
        let shortStyle = date.toLocalizedString(dateStyle: .short)
        let mediumStyle = date.toLocalizedString(dateStyle: .medium)
        let longStyle = date.toLocalizedString(dateStyle: .long)
        
        XCTAssertNotEqual(shortStyle, mediumStyle)
        XCTAssertNotEqual(mediumStyle, longStyle)
    }
    
    func testExtractDates() {
        let text = "Встреча назначена на 2023-01-15, а дедлайн 2023-02-28"
        let dates = text.extractDates()
        XCTAssertEqual(dates.count, 2)
        
        let calendar = Calendar.current
        let firstComponents = calendar.dateComponents([.year, .month, .day], from: dates[0])
        XCTAssertEqual(firstComponents.year, 2023)
        XCTAssertEqual(firstComponents.month, 1)
        XCTAssertEqual(firstComponents.day, 15)
        
        let secondComponents = calendar.dateComponents([.year, .month, .day], from: dates[1])
        XCTAssertEqual(secondComponents.year, 2023)
        XCTAssertEqual(secondComponents.month, 2)
        XCTAssertEqual(secondComponents.day, 28)
    }
    
    func testDateToISO8601String() {
        let components = DateComponents(year: 2023, month: 1, day: 15, hour: 12, minute: 30, second: 45)
        let date = Calendar.current.date(from: components)!
        
        let isoString = date.toISO8601String()
        
        // ISO8601 имеет формат типа "2023-01-15T12:30:45Z"
        XCTAssertTrue(isoString.contains("2023-01-15T"))
        XCTAssertTrue(isoString.contains("12:30:45"))
    }
    
    func testFromISO8601() {
        let isoString = "2023-01-15T12:30:45Z"
        let date = isoString.fromISO8601()
        XCTAssertNotNil(date)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date!)
        XCTAssertEqual(components.year, 2023)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 12)
        XCTAssertEqual(components.minute, 30)
        XCTAssertEqual(components.second, 45)
    }
    
    func testToSmartDateString() {
        let now = Date()
        XCTAssertEqual(now.toSmartDateString(), "Сегодня")
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        XCTAssertEqual(yesterday.toSmartDateString(), "Вчера")
        
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: now)!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        XCTAssertEqual(twoDaysAgo.toSmartDateString(), formatter.string(from: twoDaysAgo))
    }
    
    static var allTests = [
        ("testToDate", testToDate),
        ("testToDateWithCustomFormat", testToDateWithCustomFormat),
        ("testToDateWithLocale", testToDateWithLocale),
        ("testIsValidDate", testIsValidDate),
        ("testDateToString", testDateToString),
        ("testDateToStringWithCustomFormat", testDateToStringWithCustomFormat),
        ("testDateToRelativeString", testDateToRelativeString),
        ("testDateToLocalizedString", testDateToLocalizedString),
        ("testExtractDates", testExtractDates),
        ("testDateToISO8601String", testDateToISO8601String),
        ("testFromISO8601", testFromISO8601),
        ("testToSmartDateString", testToSmartDateString)
    ]
} 