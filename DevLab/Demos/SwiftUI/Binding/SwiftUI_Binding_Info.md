# SwiftUI @Binding Demo

This demo illustrates how to use the `@Binding` property wrapper in SwiftUI to create a shared, two-way connection between a parent view’s state and a child view’s UI. The parent view owns the actual state, while the child view can read and update it via the `@Binding`.

## Use Cases

* Passing mutable state down to child views.
* Creating reusable components that need to modify state externally.
* Keeping multiple views in sync through shared state.
* Maintaining a single source of truth while allowing multiple controls to interact with the data.

## Apple Documentation

[SwiftUI @Binding Documentation](https://developer.apple.com/documentation/swiftui/binding)

## How It Works

In this demo, the parent view owns a `@State` variable (`isOn`) and passes it as a `@Binding` to one or more child views. The child views do not own the data, but can still read and mutate it. This enables the parent and children to stay in sync automatically.

The UI demonstrates this using:
- A parent section that displays the current value of `isOn`.
- A child view (`ToggleButton`) that toggles the state via a button.
- Optional: multiple child controls (e.g., button and switch) can be added to show state sync in action.

The key part is how the binding is passed and used:

```swift
struct ParentView: View {
    @State private var isOn: Bool = false

    var body: some View {
        ToggleButton(isOn: $isOn)
    }
}

struct ToggleButton: View {
    @Binding var isOn: Bool

    var body: some View {
        Button(isOn ? "Turn Off" : "Turn On") {
            isOn.toggle()
        }
    }
}
