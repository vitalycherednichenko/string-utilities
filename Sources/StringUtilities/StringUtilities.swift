// The Swift Programming Language
// https://docs.swift.org/swift-book

/// StringUtilities
///
/// Набор полезных расширений для работы со строками в Swift.
/// Модуль предоставляет удобные методы для валидации, форматирования и преобразования строк.
///
/// ## Основные возможности:
/// 
/// - Валидация строк: проверка email, URL, числовых и буквенных строк
/// - Форматирование: изменение регистра, обрезка, маскирование
/// - Работа с датами: конвертация строк в даты и обратно
/// - Работа с подстроками: поиск, разбиение и манипуляции
///
/// ## Пример использования:
///
/// ```swift
/// import StringUtilities
///
/// let email = "test@example.com"
/// if email.isValidEmail() {
///     print("Email валиден")
/// }
///
/// let formatted = "hello world".capitalizeFirstLetter() // "Hello world"
/// let chunks = "123456789".chunked(intoGroupsOf: 3) // ["123", "456", "789"]
/// ```

import Foundation
