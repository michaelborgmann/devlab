# SwiftUI @EnvironmentObject Demo

This demo showcases the `@EnvironmentObject` property wrapper in SwiftUI, which enables you to **share state** across views in the view hierarchy. It provides a clean, efficient way to manage and access global or shared data without needing to pass it manually between views.

## What This Demo Shows

- How to create a shared model and inject it into the environment using `@EnvironmentObject`.
- How views can access and modify shared state via `@EnvironmentObject` without directly passing it through the view hierarchy.
- How changes to the shared state are reflected across all views that use `@EnvironmentObject`.

## Key Concepts

- **`@EnvironmentObject`**: A property wrapper that allows you to inject a shared object into the environment and access it from any child view in the view hierarchy.
- **Global State**: The shared object (e.g., a model) persists across multiple views. When the object changes, SwiftUI automatically updates all views that depend on it.

## Code Example

## Simple Code Example

### Step 1: Define the Shared Model

```swift
class CounterModel: ObservableObject {
    @Published var count = 0
}
```

### Step 2: Inject the Model into the Environment

```swift
struct RootView: View {
    @StateObject private var model = CounterModel()

    var body: some View {
        ChildView()
            .environmentObject(model)  // Inject the shared model
    }
}
```

### Step 3: Access the Model in Child Views

```swift
struct ChildView: View {
    @EnvironmentObject var model: CounterModel

    var body: some View {
        VStack {
            Text("Count: \(model.count)")
            Button("Increase") {
                model.count += 1  // Update shared state
            }
        }
    }
}
```

## How It Works

- The `CounterModel` is created in the root view and injected into the environment.
- The child view accesses the model using `@EnvironmentObject, and any updates to the `count variable are automatically reflected in both the root and child views.

## Use Case

- Share data such as settings, user preferences, or app-wide themes across multiple views.

## Documentation

[@EnvironmentObject Documentation](https://developer.apple.com/documentation/swiftui/environmentobject)
