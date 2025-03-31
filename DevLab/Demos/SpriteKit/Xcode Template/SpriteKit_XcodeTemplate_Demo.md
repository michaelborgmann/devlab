#  SpriteKit Xcode Template Demo

This demo showcases the default SpriteKit setup from the Xcode SpriteKit Game template. It demonstrates basic interaction with the scene, including touch or mouse-based events to trigger animations and effects.

## Use Cases

* Creating a basic SpriteKit scene.
* Handling touch or mouse events to trigger actions.
* Animating nodes within the scene.

## Apple Documentation

[SpriteKit Documentation](https://developer.apple.com/documentation/spritekit)

## How It Works

This demo uses the default SpriteKit `GameScene` to set up a simple interactive environment. The `GameScene` handles touch or mouse events, creating animated spinny nodes when the user interacts with the screen. The `SKLabelNode` fades in as part of the scene setup.

### Key Features:

* **Touch/Mac Mouse Interaction**: The demo responds to user input with visual feedback (spinny nodes).
* **Scene Setup**: The scene loads from an `.sks` file and sets up a label node with a fade-in animation.

## Customization Options

You can easily customize the demo by modifying the actions in the `GameScene` class or adding new nodes to the scene. To add a new node, simply add it to the scene setup function (`setUpScene`) or create new event-handling methods.
