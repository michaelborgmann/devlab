#  SwiftUI Picker Demo

This demo showcases different ways to use pickers in SwiftUI, including styling, selection management, and state updates.

## Use Cases

* Allowing users to select from a predefined list of options.
* Providing input controls for forms, settings, or categories.
* Enabling dynamic choice selection within a given set of options.

## Apple Documentation

[SwiftUI Picker Documentation](https://developer.apple.com/documentation/swiftui/picker)

## How It Works

This demo demonstrates the use of SwiftUI's Picker component with various modifiers like `.onChange()`, `.pickerStyle(), and managing the selection.

Customization Options

You can easily customize the demo by modifying the list of options, selection binding, and picker style. To add a new picker, simply copy the existing code and adjust its properties:

```
@State private var selectedOption: Int = 0

Picker("Select Option", selection: $selectedOption) {
    Text("Option 1").tag(0)
    Text("Option 2").tag(1)
    Text("Option 3").tag(2)
}
.pickerStyle(SegmentedPickerStyle())
.onChange(of: selectedOption) { newValue in
    print("Picker selection changed to \(newValue)")
}
```
