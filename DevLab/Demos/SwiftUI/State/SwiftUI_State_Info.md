#  SwiftUI @State Demo

This demo showcases how to use the `@State property wrapper in SwiftUI to manage local view state. It demonstrates toggling between two states (On/Off), with automatic UI updates when the state changes.

## Use Cases

* Managing simple local state within a view.
* Toggling between two states, such as "On" and "Off", "Play" and "Pause", etc.
* Reactively updating the UI based on changes in state.

## Apple Documentation

[SwiftUI @State Documentation](https://developer.apple.com/documentation/swiftui/state)

## How It Works

This demo demonstrates the use of SwiftUI's `@State` property wrapper to bind a local state variable (`isOn`) to a view. When the state changes (e.g., when a button is pressed), SwiftUI automatically updates the UI. The example toggles a button between "On" and "Off" states.

The `@State` variable is used to track the current state, and the UI updates reactively based on the state’s value:

```
struct OnOffButton: View {
    @State private var isOn: Bool = false
    
    var body: some View {
        Button(isOn ? "Off" : "On") {
            isOn.toggle()
        }
    }
}
```
