# SCPageControl
[![CI Status](http://img.shields.io/travis/myoung/SCPageControl.svg?style=flat)](https://travis-ci.org/myoung/SCPageControl)
[![Version](https://img.shields.io/cocoapods/v/SCPageControl.svg?style=flat)](http://cocoapods.org/pods/SCPageControl)
[![License](https://img.shields.io/cocoapods/l/SCPageControl.svg?style=flat)](http://cocoapods.org/pods/SCPageControl)
[![Platform](https://img.shields.io/cocoapods/p/SCPageControl.svg?style=flat)](http://cocoapods.org/pods/SCPageControl)

## Description
Scrolling A page control that moves in sync with the page movement distance.

#### Next Update Todo

 - [x] <del>Apply disable_color another design.</del> disable_color is not beautiful


## ScreenShot
![](https://github.com/myoungsc/SCPageControl/blob/master/ScreenShot/SCPageControl.gif)

## Requirements
```
* Swift 5.0
* XCode 10.2 (10E125)
* iOS 9.0 (Min SDK)
* Not Use Autolayout
```

## Installation
SCPageControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
//Swift 5.0
pod "SCPageControl"

//Swift 4.2
pod "SCPageControl", '-> 0.3.2'

//Swift 4.0
pod "SCPageControl", '-> 0.2.1'


//After
pod install
```

## How To Use
```Swift
import SCPageControl

public enum SCPageStyle: Int {
    case SCNormal = 100
    case SCJAMoveCircle // Design by Jardson Almeida
    case SCJAFillCircle // Design by Jardson Almeida
    case SCJAFlatBar // Design by Jardson Almeida
}

let sc = SCPageControlView()

override func viewDidLoad() {
    super.viewDidLoad()

	sc.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50)
	sc.scp_style = .SCNormal
	sc.set_view(5, current: 0, current_color: .red)
	view.addSubview(sc)
}

//MARK: ScrollView Delegate
func scrollViewDidScroll(_ scrollView: UIScrollView) {
	sc.scroll_did(scrollView)
}
```


## Author
myoung

[HomePage](http://devsc.tistory.com)

<myoungsc.dev@gmail.com>

## Design And Help
```
SCJA series Design is "Jardson Almeida", e-mail is "hello@jardsonalmeida.com"
```

```
Algorithm Help
Jangbyeonghui to PeopleRoad
```

## License
SCPageControl is available under the MIT license. See the LICENSE file for more info.
