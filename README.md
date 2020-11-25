# HoloTableViewDiffPlugin

[![CI Status](https://img.shields.io/travis/gonghonglou/HoloTableViewDiffPlugin.svg?style=flat)](https://travis-ci.org/gonghonglou/HoloTableViewDiffPlugin)
[![Version](https://img.shields.io/cocoapods/v/HoloTableViewDiffPlugin.svg?style=flat)](https://cocoapods.org/pods/HoloTableViewDiffPlugin)
[![License](https://img.shields.io/cocoapods/l/HoloTableViewDiffPlugin.svg?style=flat)](https://cocoapods.org/pods/HoloTableViewDiffPlugin)
[![Platform](https://img.shields.io/cocoapods/p/HoloTableViewDiffPlugin.svg?style=flat)](https://cocoapods.org/pods/HoloTableViewDiffPlugin)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## What's for

HoloTableViewDiffPlugin is a plugin for [HoloTableView](https://github.com/gonghonglou/HoloTableView) framework, which provide the diff reload actions support for [DeepDiff](https://github.com/onmyway133/DeepDiff).

To use it, simply make sure you use DeepDiff and import this plugin.

## Usage

```swift
let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
self.view.addSubview(tableView)

tableView.holo_makeRows { (make) in
    for item in [Int]() {
        _ = make.row(TableViewCell.self).model(item).diffId(item)
    }
}
tableView.reloadData()

// diff reload
tableView.stored()

tableView.holo_removeAllSections()
tableView.holo_makeRows { (make) in
    for item in [Int]() {
        _ = make.row(TableViewCell.self).model(item).diffId(item)
    }
}

tableView.reload()
```
If the tableView has been reload and then you want to diff reload, you need to perform `tableView.stored()` before `tableView.holo_makeRows{}`.

## Installation

HoloTableViewDiffPlugin is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HoloTableViewDiffPlugin'
```

## Author

gonghonglou, gonghonglou@icloud.com

## License

HoloTableViewDiffPlugin is available under the MIT license. See the LICENSE file for more info.
