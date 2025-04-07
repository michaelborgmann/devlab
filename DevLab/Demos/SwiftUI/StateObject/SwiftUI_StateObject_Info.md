#  SwiftUI @StateObject Demo

This demo illustrates how to use the `@StateObject` property wrapper in SwiftUI to **own and preserve the lifecycle of an observable object** across view reloads and re-creations.

It visually demonstrates how `@StateObject` retains the same instance of a view model (`PersistentCounterModel`) even when the view showing it is swapped out and back in — **no console needed**.

## 🧠 Why Use @StateObject?
Use `@StateObject` when **this view is responsible for creating and owning the lifecycle** of the observable object.

If you were to use `@ObservedObject` in the same scenario, the model would be recreated each time the view is destroyed and recreated — which may lead to lost data or unexpected behavior.

## ✅ Use Cases

- Creating and owning a `ViewModel` inside a view.
- Ensuring the model is **only initialized once**.
- Maintaining state when switching between views that reference the same `@StateObject`.

## 🧪 What This Demo Shows

- A counter stored in a view model (`PersistentCounterModel`).
- A **view switch button** that swaps between two views ("View A" and "View B").
- **A unique identifier (`id`) displayed on screen** proving that the model persists.
- When switching views, the counter and ID persist — confirming it's the **same instance**.

## 🧩 Key Concept

```swift
@StateObject private var model = PersistentCounterModel()
```

This tells SwiftUI:

> “Create this object once, and preserve it even if this view is redrawn or recreated.”

Then it’s passed to a child view as:

```swift
@ObservedObject var model: PersistentCounterModel
```

This means the child observes changes but **doesn't own** the model.

## 🔗 Apple Documentation

- [@StateObject Documentation](https://developer.apple.com/documentation/swiftui/stateobject)
