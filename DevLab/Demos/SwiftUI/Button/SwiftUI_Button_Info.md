# SwiftUI Button

This demo shows different ways to use buttons in SwiftUI, including styling, animations, and feedback effects.

## Use Cases
- Performing actions when tapped.
- Navigating to new screens.
- Triggering animations or effects.

## Apple Documentation
[SwiftUI Button Documentation](https://developer.apple.com/documentation/swiftui/button)

## How It Works
This demo demonstrates the use of SwiftUI's `Button` component with various modifiers like `.style()`, `.animation()`, and `.onTapGesture()`.

## Customization Options
You can easily customize the demo by adding new button styles or changing the button's action. To add a new button, simply copy the existing code and modify the action:

```swift
Button(action: {
    print("New action")
}) {
    Text("New Button")
}
```
