#  SwiftUI TextField Demo

This demo showcases different ways to use `TextField` in SwiftUI, including text input, validation, and state management.

## Use Cases

* Allowing users to input text in forms, search bars, or settings.
* Providing an editable field for data entry like names, emails, or messages.
* Enabling real-time text validation and feedback.

## Apple Documentation

[SwiftUI TextField Documentation](https://developer.apple.com/documentation/swiftui/textfield)

## How It Works

This demo demonstrates the use of SwiftUI's `TextField` component with various modifiers like `.onChange()`, `.textFieldStyle()`, and managing text input states.

**Customization Options**

You can easily customize the demo by modifying the text input, adding validation logic, and adjusting the text field style. To add a new `TextField`, simply copy the existing code and adjust its properties:

```
@State private var name: String = ""

TextField("Enter your name", text: $name)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
    .onChange(of: name) { newValue in
        print("TextField content changed to \(newValue)")
    }
```
