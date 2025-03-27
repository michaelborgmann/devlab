#  SwiftUI DatePicker Demo

This demo showcases different ways to use `DatePicker` in SwiftUI, including styling, date formatting, and state updates.

## Use Cases

* Allowing users to select a date and/or time.
* Collecting input for birthdates, appointments, or deadlines.
* Enabling date range selections for filters or event management.
* Providing a visual date and time picker in a simple and intuitive interface.

## Apple Documentation

[SwiftUI DatePicker Documentation](https://developer.apple.com/documentation/swiftui/datepicker)

## How It Works

This demo demonstrates the use of SwiftUI's `DatePicker` component with various modifiers like `.datePickerStyle()`, `.onChange()`, and formatting options to display the selected date. You can also observe how to bind the selected date to state and update other UI elements dynamically.

### Customization Options

You can easily customize the demo by modifying the date range, time format, and display style. To add a new `DatePicker, simply copy the existing code and adjust its properties:

```
@State private var selectedDate: Date = Date()

DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
    .datePickerStyle(WheelDatePickerStyle())
    .onChange(of: selectedDate) { newDate in
        print("Selected Date: \(newDate)")
    }
    .padding()
```

### Example of DatePicker Styles:

* **Wheel Style**: A compact, vertical date picker that can be scrolled.
* **Compact Style**: A small horizontal view displaying a date range.
* **Graphical Style**: A calendar view for selecting a specific date.
* **Inline Style**: A dropdown-style date picker that opens inline with other content.
