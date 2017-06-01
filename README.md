# ICTabFragment
Tab menu with page view controller

## Minimum Requirements

iOS9+
Swift 3.0
XCode 8.0

## Installation

### Using CocoaPods

```ruby
source 'https://github.com/ioscodigo/ICTabFragment.git'
use_frameworks!
pod 'ICTabFragment'
```

## Usage

1. `Create ViewController` and also ViewController class (Parent ViewController)
2. `Add UIView` that will use as tab menu bar
3. `Add UIView` that will use as container child ViewController
4. `Create child ViewController` (more than 1 ViewController) don't forget to set identifier of each ViewController
5. `Import ICTabFragment` to use ICTabFragment in your file.
6. `Inherit ICTabFragmentViewController` on your parent ViewController
7. `Define each tab name and viewcontroller` and also set isSelected to `false` except on first model set isSelected to `true`
8. If you want to custom text color and indicator set properties of tab
9. If you want to customize size tab set size properties of tab


### Example 

```swift
import UIKit
import ICTabFragment

class ViewController: ICTabFragmentViewController {
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabs = [
            ICTabModel(tabName: "One", tabView: storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController, isSelected: true),
            ICTabModel(tabName: "Two", tabView: storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController, isSelected: false),
            ICTabModel(tabName: "Three", tabView: storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController, isSelected: false)
        ]
        
        self.create(tabView: tabView, containerView: containerView, tabModel: tabs)
    }
}
```

## Custom Properties

If you want to custom tab menu then you can set properties and send to create method
#####  custom text color and custom indicator color

```swift
let properties = [
            "textColorSelected" : UIColor.blue,
            "textColorUnselected" : UIColor.cyan,
            "indicatorColorSelected" : UIColor.blue,
            "indicatorColorUnselected" : UIColor.cyan
        ]
```

##### Type of tab (Dynamic or fit screen)

```swift
let sizeProperties = [
         "tabSize" : ICTabSize.fit, //Default is dynamic
         "tabFitSize" : 3
         ] as [String : Any]
```

##### Initialization each properties on create function
```swift
self.create(tabView: tabView, containerView: containerView, tabModel: tabs, tabProperties: properties, tabSizeProperties: sizeProperties)
```
## Author

2017, Digital Khrisna Aurum

## License

ICTabFragment is available under the MIT license. See the LICENSE file for more info.
