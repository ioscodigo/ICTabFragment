# ICTabFragment
Tab menu with page view controller

![](https://github.com/ioscodigo/ICTabFragment/blob/master/Images/first.gif)
![](https://github.com/ioscodigo/ICTabFragment/blob/master/Images/second.gif)

## Minimum Requirements

iOS9+
Swift 3.0
XCode 8.0

## Installation

### Using CocoaPods

```ruby
pod 'ICTabFragment'
```

## Usage

1. `Create ViewController` and also ViewController class (Parent ViewController)
2. `Add UIView` that will use as tab menu bar
3. `Add UIView` that will use as container child ViewController
4. `Create child ViewController` (more than 1 ViewController) don't forget to set identifier of each ViewController
5. `Import ICTabFragment` to use ICTabFragment in your file.

### Example 

```swift
import UIKit
import ICTabFragment

class ViewController: UIViewController {
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs = [
            ICTabModel(tabName: "One", tabView: storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController),
            ICTabModel(tabName: "Two", tabView: storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController),
            ICTabModel(tabName: "Three", tabView: storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController)
        ]
        
        let tabFragment = ICTabFragmentViewController(context: self, tabs: tabs, tabView: viewTest, containerView: containerTest)
        tabFragment.create()
    }
}
```

## Custom Properties

If you want to custom tab menu then you can set properties before create method was called

```swift
    open var textColorSelected: UIColor
    
    open var textColorUnselected: UIColor
    
    open var indicatorColorSelected: UIColor
    
    open var indicatorHeight: CGFloat
    
    open var indicatorTopSpace: CGFloat
    
    open var textFont: UIFont
    
    open var tabSize: ICTabSize
    
    open var tabFitSize: CGFloat
    
    open var tabLineSpacing: CGFloat
    
    open var tabInterSpacing: CGFloat
```

then call create method
```swift
    tabFragment.create()
```
## Author

2017, Digital Khrisna Aurum, digital@codigo.id

## License

ICTabFragment is available under the MIT license. See the LICENSE file for more info.
