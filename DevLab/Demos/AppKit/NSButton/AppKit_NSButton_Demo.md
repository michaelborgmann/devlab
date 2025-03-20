#  AppKit NSButton Demo

This demo illustrates how to create and customize `NSButton` in AppKit, including setting up actions, styling, and accessibility options.

## Use Cases

* Performing actions when clicked.
* Triggering UI updates or animations.
* Opening dialogs or new windows.

## Apple Documentation

* [AppKit NSButton Documentation](https://developer.apple.com/documentation/appkit/nsbutton)

## How It Works

This demo shows how to use `NSButton` programmatically, including setting its title, adding target actions, and applying Auto Layout constraints for proper positioning.

## Customization Options

You can easily customize the demo by modifying the button’s style, title, and action. To add a new button, use the following code:

```swift
let newButton = NSButton(title: "New Button", target: self, action: #selector(buttonAction))
newButton.bezelStyle = .rounded
view.addSubview(newButton)
```

Make sure to define `buttonAction` as a function inside your view controller:

```swift
@objc private func buttonAction() {
    print("New button clicked")
}
```
