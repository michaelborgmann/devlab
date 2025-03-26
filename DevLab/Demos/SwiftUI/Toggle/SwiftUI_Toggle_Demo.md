#  SwiftUI Toggle Demo

This demo showcases different ways to use toggles in SwiftUI, including styling, animations, and state management.

## Use Cases

* Enabling or disabling features.
* Managing user preferences.
* Controlling UI elements dynamically.

## Apple Documentation

[SwiftUI Toggle Documentation](https://developer.apple.com/documentation/swiftui/toggle)

## How It Works

This demo demonstrates the use of SwiftUI's Toggle component with various modifiers like `.toggleStyle()`, `.onChange()`, and `.animation()`.

## Customization Options

You can easily customize the demo by modifying the toggle styles or its state management. To add a new toggle, simply copy the existing code and adjust its properties:

```swift
@State private var isOn = false

Toggle("New Toggle", isOn: $isOn)
    .toggleStyle(SwitchToggleStyle())
    .onChange(of: isOn) { newValue in
        print("Toggle changed to \(newValue)")
    }
```
