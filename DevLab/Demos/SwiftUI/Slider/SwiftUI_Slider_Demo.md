#  SwiftUI Slider Demo

This demo showcases different ways to use sliders in SwiftUI, including styling, range limits, and state management.

## Use Cases

* Adjusting numeric values smoothly.
* Providing input controls for settings like volume or brightness.
* Allowing users to select values within a range dynamically.

## Apple Documentation

[SwiftUI Slider Documentation](https://developer.apple.com/documentation/swiftui/slider)

## How It Works

This demo demonstrates the use of SwiftUI's Slider component with various modifiers like `.onChange(), custom labels, and value formatting.

Customization Options

You can easily customize the demo by modifying the range, step size, and labels. To add a new slider, simply copy the existing code and adjust its properties:

```
@State private var value: Double = 0.5  

Slider(value: $value, in: 0...1, step: 0.1)  
    .onChange(of: value) { newValue in  
        print("Slider changed to \(newValue)")  
    }
```
