# SCPageControl

[![CI Status](http://img.shields.io/travis/myoung/SCPageControl.svg?style=flat)](https://travis-ci.org/myoung/SCPageControl)
[![Version](https://img.shields.io/cocoapods/v/SCPageControl.svg?style=flat)](http://cocoapods.org/pods/SCPageControl)
[![License](https://img.shields.io/cocoapods/l/SCPageControl.svg?style=flat)](http://cocoapods.org/pods/SCPageControl)
[![Platform](https://img.shields.io/cocoapods/p/SCPageControl.svg?style=flat)](http://cocoapods.org/pods/SCPageControl)

## Description

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## ScreenShot
![](https://github.com/myoungsc/SCPageControl/blob/master/SCPageControl.gif)

## Requirements
```
* Swift 3.0.1
* XCode 8.3.1
* iOS 9.0 (Min SDK)
* Not Use Autolayout
```


## Installation

SCPageControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SCPageControl"
```

## How To Use

```Swift
let sc = SCPageControlView()

override func viewDidLoad() {
    super.viewDidLoad()

	sc.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50)
	sc.backgroundColor = UIColor.white
	sc.set_view(5, current: 0, tint_color: UIColor.red)
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

## License

SCPageControl is available under the MIT license. See the LICENSE file for more info.
