#  UIKit UIButton Demo

This demo illustrates how to create and customize `UIButton` in UIKit, including setting up actions, styling, and accessibility options.

## Use Cases

* Performing actions when tapped.
* Navigating to new screens.
* Triggering animations or feedback effects.

## Apple Documentation

* [UIKit UIButton Documentation](https://developer.apple.com/documentation/uikit/uibutton)

## How It Works

This demo shows how to use `UIButton programmatically, including setting up its title, adding target actions, and applying Auto Layout constraints for proper positioning.

## Customization Options

You can easily customize the demo by modifying the button’s style, size, and action. To add a new button, you can use the following code:

```swift
let newButton = UIButton(type: .system)
newButton.setTitle("New Button", for: .normal)
newButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
view.addSubview(newButton)
```

Make sure to define `buttonAction as a function inside your view controller:

```swift
@objc private func buttonAction() {
    print("New button tapped")
}
```
