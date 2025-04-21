# StringUtilities Installation Guide

This guide provides detailed instructions for installing and integrating StringUtilities into your Swift projects.

## Swift Package Manager

The Swift Package Manager is the preferred way to add StringUtilities to your project.

### In Xcode

1. Open your project in Xcode
2. Select **File > Add Packages...**
3. Enter the repository URL: `https://github.com/username/StringUtilities.git`
4. Choose the version you want to use:
   - Select **Exact Version** for a specific version
   - Select **Up to Next Major Version** for automatic updates within the same major version
   - Select **Branch** and specify **main** for the latest development version
5. Click **Add Package**
6. Choose the target(s) you want to add StringUtilities to
7. Click **Add Package**

### In Package.swift

Add StringUtilities as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/username/StringUtilities.git", from: "1.0.0")
]
```

Then add the dependency to your target:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["StringUtilities"]),
]
```

## CocoaPods

Currently, StringUtilities is not available through CocoaPods.

## Manual Installation

1. Download or clone the repository: `git clone https://github.com/username/StringUtilities.git`
2. Drag the `Sources/StringUtilities` folder into your Xcode project
3. Make sure **Copy items if needed** is checked and select the appropriate targets
4. Click **Finish**

## Importing

After installation, import StringUtilities in your Swift files:

```swift
import StringUtilities
```

## Requirements

- Swift 6.1+
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+

## Troubleshooting

If you encounter issues with the installation:

1. Make sure you're using the correct repository URL
2. Check if your Swift version meets the requirements
3. Try cleaning your build folder (**Product > Clean Build Folder**)
4. Update Xcode to the latest version
5. If using SPM, try resetting the package caches (**File > Packages > Reset Package Caches**)

---

# Руководство по установке StringUtilities

Это руководство содержит подробные инструкции по установке и интеграции StringUtilities в ваши проекты Swift.

## Swift Package Manager

Swift Package Manager — предпочтительный способ добавления StringUtilities в ваш проект.

### В Xcode

1. Откройте ваш проект в Xcode
2. Выберите **File > Add Packages...**
3. Введите URL репозитория: `https://github.com/username/StringUtilities.git`
4. Выберите версию, которую хотите использовать:
   - Выберите **Exact Version** для конкретной версии
   - Выберите **Up to Next Major Version** для автоматических обновлений в пределах одной мажорной версии
   - Выберите **Branch** и укажите **main** для последней разрабатываемой версии
5. Нажмите **Add Package**
6. Выберите целевые проекты, в которые вы хотите добавить StringUtilities
7. Нажмите **Add Package**

### В Package.swift

Добавьте StringUtilities как зависимость в ваш файл `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/username/StringUtilities.git", from: "1.0.0")
]
```

Затем добавьте зависимость к вашей цели:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["StringUtilities"]),
]
```

## CocoaPods

В настоящее время StringUtilities не доступен через CocoaPods.

## Ручная установка

1. Скачайте или клонируйте репозиторий: `git clone https://github.com/username/StringUtilities.git`
2. Перетащите папку `Sources/StringUtilities` в ваш проект Xcode
3. Убедитесь, что опция **Copy items if needed** отмечена, и выберите соответствующие цели
4. Нажмите **Finish**

## Импорт

После установки импортируйте StringUtilities в ваших Swift-файлах:

```swift
import StringUtilities
```

## Требования

- Swift 6.1+
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+

## Устранение неполадок

Если у вас возникли проблемы с установкой:

1. Убедитесь, что вы используете правильный URL репозитория
2. Проверьте, соответствует ли ваша версия Swift требованиям
3. Попробуйте очистить папку сборки (**Product > Clean Build Folder**)
4. Обновите Xcode до последней версии
5. Если вы используете SPM, попробуйте сбросить кеши пакетов (**File > Packages > Reset Package Caches**) 