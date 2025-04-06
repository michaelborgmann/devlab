# SwiftUI @ObservedObject Demo

This demo showcases how to use the `@ObservedObject` property wrapper in SwiftUI to observe and react to changes in an external `ObservableObject`.

It illustrates the relationship between a parent view (which owns the model) and a child view (which observes and modifies it), demonstrating how changes in the model automatically trigger UI updates.

---

## Use Cases

- Sharing state between parent and child views.
- Observing changes in an external data model or view model.
- Separating business logic into an observable object.
- Building reusable views that depend on shared data.

---

## Apple Documentation

[SwiftUI @ObservedObject Documentation](https://developer.apple.com/documentation/swiftui/observedobject)

---

## How It Works

This demo uses a `CounterModel` class that conforms to `ObservableObject`. The model contains a `@Published` property (`count`) which emits updates when changed.

The parent view owns the model using `@StateObject`, while the child view receives and observes it via `@ObservedObject`. Both views can read and update the model, and SwiftUI ensures the UI stays in sync.

```swift
final class CounterModel: ObservableObject {
    @Published var count: Int = 0
}
```

In the parent view:

```swift
@StateObject private var model = CounterModel()

CounterControls(model: model) // pass down to child
```

In the child view:

```swift
struct CounterControls: View {
    @ObservedObject var model: CounterModel

    var body: some View {
        Button("Add") {
            model.count += 1
        }
    }
}
```

## Key Concepts

- `@ObservedObject` should be used when the model is owned by another view.
- Changes to `@Published` properties trigger automatic view updates.
- Use `@StateObject when you need the view to own the object.
