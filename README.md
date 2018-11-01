# Spatial
Definition: **Spatial** | ˈspeɪʃ(ə)l | adjective | **describes how objects fit together in space**

<img width="900" alt="img" src="https://rawgit.com/stylekit/img/master/spatial_github.svg">

### What is it
Hassle-free AutoLayout, tailored for interactivity and animation.

### How does it work
- Spatial is just extensions and enums which enable you to write less boilerplate code
- Spatial is interchangeable with Vanilla AutoLayout
- Spatial comes with examples how you can animate with AutoLayout
- Spatial uses plain and simple math under the hood.

### How do I get it
- Carthage `github "eonist/Spatial"`
- Manual Open `Spatial.xcodeproj`
- CocoaPod (Coming soon)

### Competition:
- Carthography https://github.com/robb/Cartography , codebeat, loc , stars
- TinyConstraint https://github.com/roberthein/TinyConstraints , codebeat, loc, stars
- Apple NSLayoutConstraint SDK API, Pros: Raw power, Cons: Extremely verbose; tedious to write; difficult to read
- Neon https://github.com/mamaral/Neon, great visual examples
- Anchors https://github.com/onmyway133/Anchors, sickest layout DSL out there, but too magical and alien for some.
### Example:

```swift
button.constrain { view in
	return (stretch:(w:100,h:100),pin:(to:view.parent, at:.topLeft, pivot:.topLeft,inset:UIEdgeInset))//x:.left, y:.top
}
```
### Todo:
- Complete the spaceAround and spaceBetween methods
- Add one-liner accessors
