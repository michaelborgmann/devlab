#  SwiftUI Stepper Demo

This demo showcases different ways to use steppers in SwiftUI, including styling, range limits, and state management.

## Use Cases

* Adjusting numeric values with precision.
* Providing input controls for forms.
* Incrementing or decrementing values dynamically.

## Apple Documentation

[SwiftUI Stepper Documentation](https://developer.apple.com/documentation/swiftui/stepper)

## How It Works

This demo demonstrates the use of SwiftUI's Stepper component with various modifiers like `.onChange(), custom labels, and step increments.

## Customization Options

You can easily customize the demo by modifying the step size, range, and labels. To add a new stepper, simply copy the existing code and adjust its properties:

```
@State private var value = 0  

Stepper("Value: \(value)", value: $value, in: 0...10, step: 1)  
    .onChange(of: value) { newValue in  
        print("Stepper changed to \(newValue)")  
    }
```
