import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit)
public typealias AttributedStringColor = UIColor
public typealias AttributedStringFont = UIFont
#elseif canImport(AppKit)
public typealias AttributedStringColor = NSColor
public typealias AttributedStringFont = NSFont
#endif

public extension String {
    
    /// Создает атрибутированную строку с заданным шрифтом
    /// - Parameters:
    ///   - font: Шрифт для строки
    /// - Returns: NSAttributedString с примененным шрифтом
    func withFont(_ font: AttributedStringFont) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.font: font])
    }
    
    /// Создает атрибутированную строку с заданным цветом
    /// - Parameters:
    ///   - color: Цвет для строки
    /// - Returns: NSAttributedString с примененным цветом
    func withColor(_ color: AttributedStringColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.foregroundColor: color])
    }
    
    /// Создает атрибутированную строку с заданными стилями
    /// - Parameters:
    ///   - font: Шрифт для строки (опционально)
    ///   - color: Цвет для строки (опционально)
    ///   - backgroundColor: Цвет фона (опционально)
    ///   - underlined: Подчеркнутый текст (опционально)
    ///   - strikethrough: Зачеркнутый текст (опционально)
    /// - Returns: NSAttributedString с примененными стилями
    func styled(
        font: AttributedStringFont? = nil,
        color: AttributedStringColor? = nil,
        backgroundColor: AttributedStringColor? = nil,
        underlined: Bool = false,
        strikethrough: Bool = false
    ) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if let font = font {
            attributes[.font] = font
        }
        
        if let color = color {
            attributes[.foregroundColor] = color
        }
        
        if let backgroundColor = backgroundColor {
            attributes[.backgroundColor] = backgroundColor
        }
        
        if underlined {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        if strikethrough {
            attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        }
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    /// Создает HTML-атрибутированную строку из HTML-строки
    /// - Returns: NSAttributedString из HTML или обычная строка, если преобразование не удалось
    func fromHTML() -> NSAttributedString {
        guard let data = self.data(using: .utf8) else {
            return NSAttributedString(string: self)
        }
        
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            return NSAttributedString(string: self)
        }
    }
    
    /// Выделяет в строке заданную подстроку цветом
    /// - Parameters:
    ///   - substring: Подстрока для выделения
    ///   - color: Цвет выделения
    /// - Returns: NSAttributedString с выделенной подстрокой
    func highlighting(substring: String, withColor color: AttributedStringColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let fullRange = NSRange(location: 0, length: self.count)
        
        // Находим все вхождения подстроки
        var searchRange = fullRange
        var foundRange: NSRange
        
        while searchRange.location < fullRange.length {
            foundRange = (self as NSString).range(of: substring, options: [], range: searchRange)
            if foundRange.location == NSNotFound {
                break
            }
            
            attributedString.addAttribute(.foregroundColor, value: color, range: foundRange)
            searchRange.location = foundRange.location + foundRange.length
            searchRange.length = fullRange.length - searchRange.location
        }
        
        return attributedString
    }
    
    /// Применяет к части текста другой стиль
    /// - Parameters:
    ///   - range: Диапазон текста для стилизации
    ///   - attributes: Атрибуты для применения
    /// - Returns: NSAttributedString с примененным стилем к части текста
    func applyingAttributes(_ attributes: [NSAttributedString.Key: Any], toRange range: NSRange) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        if range.location != NSNotFound && range.location + range.length <= self.count {
            attributedString.addAttributes(attributes, range: range)
        }
        return attributedString
    }
    
    /// Создаёт атрибутированную строку с маркированным списком
    /// - Parameters:
    ///   - bullet: Символ маркера (по умолчанию "•")
    ///   - indentation: Размер отступа (по умолчанию 20)
    ///   - lineSpacing: Межстрочный интервал (по умолчанию 2)
    ///   - bulletColor: Цвет маркера (опционально)
    /// - Returns: NSAttributedString с маркированным списком
    func toBulletList(
        bullet: String = "•",
        indentation: CGFloat = 20,
        lineSpacing: CGFloat = 2,
        bulletColor: AttributedStringColor? = nil
    ) -> NSAttributedString {
        let items = self.components(separatedBy: "\n")
        let attributedText = NSMutableAttributedString()
        
        for (index, item) in items.enumerated() {
            // Создаем атрибутированную строку для маркера
            let bulletAttributedString = NSMutableAttributedString(string: "\(bullet) ")
            if let bulletColor = bulletColor {
                bulletAttributedString.addAttribute(.foregroundColor, value: bulletColor, 
                                                  range: NSRange(location: 0, length: bulletAttributedString.length))
            }
            
            // Создаем атрибутированную строку для пункта
            let itemAttributedString = NSAttributedString(string: item)
            
            // Настраиваем отступ
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = 0
            paragraphStyle.headIndent = indentation
            paragraphStyle.paragraphSpacing = lineSpacing
            
            // Объединяем маркер и текст
            let fullAttributedString = NSMutableAttributedString(attributedString: bulletAttributedString)
            fullAttributedString.append(itemAttributedString)
            fullAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, 
                                            range: NSRange(location: 0, length: fullAttributedString.length))
            
            // Добавляем элемент и перевод строки, если это не последний элемент
            attributedText.append(fullAttributedString)
            if index != items.count - 1 {
                attributedText.append(NSAttributedString(string: "\n"))
            }
        }
        
        return attributedText
    }
} 