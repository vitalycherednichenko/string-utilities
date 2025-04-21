# Contributing to StringUtilities

Thank you for your interest in contributing to StringUtilities! This document provides guidelines and instructions for contributing to the project.

[Русская версия](#внесение-вклада-в-stringutilities)

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR-USERNAME/StringUtilities.git`
3. Create a branch for your changes: `git checkout -b feature/your-feature-name`

## Development Environment

1. Ensure you have Xcode 14.0+ and Swift 6.1+ installed
2. Open the project in Xcode by double-clicking on `Package.swift`
3. Build the project to ensure everything is working correctly

## Making Changes

### Code Style Guidelines

- Follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use 4 spaces for indentation
- Include proper documentation comments using the `///` format
- Organize extensions logically by functionality
- Keep functions focused on a single responsibility
- Use descriptive variable and function names

### Adding New Features

1. Before adding a feature, open an issue to discuss it
2. Ensure your feature is consistent with the library's scope and design
3. Add appropriate tests for your feature
4. Update documentation to reflect your changes

### Modifying Existing Code

1. Maintain backward compatibility when possible
2. Include comments explaining the reasoning behind non-obvious changes
3. Update existing tests to ensure they still pass with your changes

## Testing Your Changes

1. Run the test suite: `swift test`
2. Ensure all tests pass before submitting a pull request
3. Add new tests to cover your changes:
   - Unit tests for new functions
   - Edge case tests for complex logic

## Documentation

- Update the README.md if your changes affect usage examples
- Update the API documentation in comments as needed
- Consider updating or adding examples if introducing new functionality

## Submitting Changes

1. Push your changes to your fork: `git push origin feature/your-feature-name`
2. Create a pull request from your fork to the main repository
3. Describe your changes in detail in the pull request
4. Reference any related issues

## Pull Request Process

1. Ensure your PR is focused on a single feature or fix
2. All tests must pass
3. Your code must meet the style guidelines
4. Wait for a code review from a maintainer
5. Address any feedback from reviewers

## Release Process

Maintainers are responsible for releases. The release process follows these steps:

1. Update version number in Package.swift
2. Update CHANGELOG.md
3. Tag a new release in the repository
4. Push the tag to trigger automated release processes

---

<a name="внесение-вклада-в-stringutilities"></a>
# Внесение вклада в StringUtilities

Спасибо за ваш интерес к внесению вклада в StringUtilities! Этот документ содержит рекомендации и инструкции по внесению вклада в проект.

## Начало работы

1. Сделайте форк репозитория
2. Клонируйте ваш форк: `git clone https://github.com/YOUR-USERNAME/StringUtilities.git`
3. Создайте ветку для ваших изменений: `git checkout -b feature/название-вашей-функции`

## Среда разработки

1. Убедитесь, что у вас установлены Xcode 14.0+ и Swift 6.1+
2. Откройте проект в Xcode, дважды нажав на `Package.swift`
3. Соберите проект, чтобы убедиться, что всё работает корректно

## Внесение изменений

### Рекомендации по стилю кода

- Следуйте [рекомендациям по дизайну API Swift](https://swift.org/documentation/api-design-guidelines/)
- Используйте 4 пробела для отступов
- Включайте правильные комментарии к документации, используя формат `///`
- Логически организуйте расширения по функциональности
- Сохраняйте функции сосредоточенными на одной задаче
- Используйте описательные имена переменных и функций

### Добавление новых функций

1. Перед добавлением функции откройте issue для её обсуждения
2. Убедитесь, что ваша функция соответствует области применения и дизайну библиотеки
3. Добавьте соответствующие тесты для вашей функции
4. Обновите документацию, чтобы отразить ваши изменения

### Изменение существующего кода

1. По возможности сохраняйте обратную совместимость
2. Включайте комментарии, объясняющие причины неочевидных изменений
3. Обновляйте существующие тесты, чтобы убедиться, что они проходят с вашими изменениями

## Тестирование ваших изменений

1. Запустите набор тестов: `swift test`
2. Убедитесь, что все тесты проходят перед отправкой пул-реквеста
3. Добавьте новые тесты для покрытия ваших изменений:
   - Модульные тесты для новых функций
   - Тесты крайних случаев для сложной логики

## Документация

- Обновите README.md, если ваши изменения влияют на примеры использования
- При необходимости обновите документацию API в комментариях
- Рассмотрите возможность обновления или добавления примеров при внедрении новой функциональности

## Отправка изменений

1. Отправьте ваши изменения в ваш форк: `git push origin feature/название-вашей-функции`
2. Создайте пул-реквест из вашего форка в основной репозиторий
3. Подробно опишите ваши изменения в пул-реквесте
4. Упомяните все связанные issues

## Процесс рассмотрения пул-реквеста

1. Убедитесь, что ваш PR сфокусирован на одной функции или исправлении
2. Все тесты должны проходить
3. Ваш код должен соответствовать рекомендациям по стилю
4. Дождитесь проверки кода от сопровождающего
5. Устраните любые замечания от рецензентов

## Процесс выпуска релиза

Сопровождающие отвечают за релизы. Процесс выпуска релиза следует этим шагам:

1. Обновление номера версии в Package.swift
2. Обновление CHANGELOG.md
3. Создание тега нового релиза в репозитории
4. Отправка тега для запуска автоматизированных процессов релиза 