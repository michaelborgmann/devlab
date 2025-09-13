# SwiftUI NavigationStack

This demo introduces the basics of navigation in SwiftUI using `NavigationStack`. It covers creating a stack, pushing with `NavigationLink`, and defining typed destinations with `navigationDestination(for:)`.

---

## Use Cases

* Navigating from a list to a detail screen.
* Structuring multi-screen flows with type-safe destinations.
* Laying the foundation for more advanced patterns (programmatic paths, multiple destination types, state restoration).

---

## Apple Documentation

* [NavigationStack](https://developer.apple.com/documentation/swiftui/navigationstack/)
* [Understanding the composition of NavigationStack](https://developer.apple.com/documentation/swiftui/understanding-the-composition-of-navigation-stack)

---

## How It Works

`NavigationStack` manages a stack of views. You present links inside the stack with `NavigationLink`, and declare how to build destination views using `navigationDestination(for:)`. In this basic demo:

* A `List` shows simple items.
* Tapping a row pushes a detail screen.
* `navigationDestination(for:)` maps the pushed value (e.g. `Int`) to a destination view.
* The demo updates a `viewModel.subtitle` to reflect where you are in the flow.

> Tip: This is the simplest pattern. More advanced variations use `NavigationPath` to push/pop programmatically and support multiple types. Those are great follow-ups once the basics are clear.

---

## Customization Options

You can tailor the demo by:

* Changing the source data (e.g., custom structs instead of `Int`).
* Adding toolbar items and title display modes.
* Integrating `.searchable` or pull-to-refresh around the list.

**Minimal example:**

```swift
struct BasicNavDemo: View {
    let items = Array(1...5)

    var body: some View {
        NavigationStack {
            List(items, id: \.self) { number in
                NavigationLink("Go to Detail \(number)", value: number)
            }
            .navigationTitle("Basic Navigation")
            .navigationDestination(for: Int.self) { number in
                VStack(spacing: 12) {
                    Text("Detail View \(number)").font(.title)
                    Text("You navigated here from the list.")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
```

---

## Accessibility Notes

* Give each link a descriptive label (e.g., “Go to Detail 3”).
* Provide hints on the root list and detail views to guide VoiceOver users.
* Prefer dynamic text–friendly layouts and verify good contrast in both light and dark modes.
