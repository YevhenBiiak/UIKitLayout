<p align="center">
    <a href="#description">Description</a>
  • <a href="#requirements">Requirements</a>
  • <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
</p>

## Description
UIKitLayout is a set of additional initializers and methods for UIKit framework.  
Inspired by SwiftUI, designed to simplify the building of a hierarchy of UIView and its subclasses

## Requirements
Swift 5.8, iOS 15

## Installation
`UIKitLayout` is installed via the official [Swift Package Manager](https://swift.org/package-manager/).  

Select `Xcode` > `File` > `Add Package Dependency...`  
and add `https://github.com/YevhenBiiak/UIKitLayout`.  
```swift 
import UIKitLayout
```

## Usage

### Add subview:   
```swift
func subview(_ alignment: ViewAlignment, _ content: () -> UIView) -> Self
```
```swift
view.subview(.fill) {
    UIView()
}
```
is equal to:
```swift
let myView = UIView()
view.addSubview(myView)
myView.translatesAutoresizingMaskIntoConstraints = false
myView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
myView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
myView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
myView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
```



### Add subview in SafeArea:  
`Important! Do not use the safeArea alignment for views that are not the root view of the UIViewController. This can give you unexpected results`

```swift
view.subview(.inSafeArea) {
    UIView()
}
```
is equal to:
```swift
let myView = UIView()
view.addSubview(myView)
myView.translatesAutoresizingMaskIntoConstraints = false
myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
myView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
myView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
myView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
```




### Ignore Top or Bottom safeAreaLayoutGuide.  
`Top or Bottom anchor of subview will be pinned so superview, not to safeAreaLayoutGuide`

```swift
view.subview(.inSafeAreaIgnoringTop) {
    UIView()
}
```
```swift
view.subview(.inSafeAreaIgnoringBottom) {
    UIView()
}
```




### Other alignment cases:
![](https://github.com/YevhenBiiak/UIKitLayout/assets/80542175/e68ccf2a-e91d-4c23-affc-de74474d3254)

In this cases, the subview may have its own calculated size or directly setted width or height constraint using:
```swift
func frame(width:_, height:_) -> Self 
```

In this example subview will be centered in root view of UIViewController. And will have width equal to 50% of superview, height equal to 100pt.  
Use `store(in ref: inout Self?) -> Self` modifier of UIView if you want to access view in the future.

```swift
class ViewController: UIViewController {
    
    private var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.subview(.center) {
            UIView()
                .frame(width: 50%, height: 100)
                .store(in: &myView)
        }
    }
}
```



### Padding and Offset
Only three UIView modifiers return another UIView container, not Self.  
```swift
func padding(_ level:_) -> UIView
func padding(left:_, right:_, top:_, bottom:_) -> UIView 
func offset(x:_, y:_) -> UIView
```
Example.  
If you want to store some view do it before appliying padding or offset!  
`frame(aspectRatio: 1/1)` == `heghtAnchor` equal to `widthAnchor`.  
90% modifiers have the same name as UIKit property, which they will change (`textAlignment`, `cornerRadius`, `clipsToBounds`, `backgroundColor`)
```swift
class ViewController: UIViewController {
    
    private var saleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.subview(.center) {
            UIView()
                .frame(width: 70%)
                .frame(aspectRatio: 1/1)
                .backgroundColor(.red)
                .subview(.topTrailing) {
                    UILabel("50%")
                        .frame(width: 80, height: 40)
                        .textAlignment(.center)
                        .cornerRadius(22)
                        .clipsToBounds(true)
                        .backgroundColor(.systemOrange)
                        .store(in: &saleLabel)
                        .offset(x: 20, y: -20)
                }
                .padding(50)
                .backgroundColor(.green)
                .padding(50)
                .backgroundColor(.blue)
        }
    }
}
```

<img width=50% src="https://github.com/YevhenBiiak/UIKitLayout/assets/80542175/f3472148-dbbc-4b89-a93b-5567dea6e639"> 

