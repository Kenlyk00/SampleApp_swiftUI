# SampleApp_swiftUI -WIP
> The Sample App is to display the amount the of data sent over Singapore’s mobile networks from 2008 to 2018.

## Features

- [x] Filtering by year or quarter
- [x] Using Swift UI for rendering
- [x] Local Storage using RealmDB
- [x] Unit Testing for Repo, ApiClient

## Requirements

- iOS 8.0+
- Xcode 11.3.1

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `YourLibrary` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'YourLibrary'
```

To get the full benefits import `YourLibrary` wherever you import UIKit

``` swift
import UIKit
import YourLibrary
```
#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/YourLibrary.framework` to an iOS project.

```
github "yourUsername/yourlibrary"
```
#### Manually
1. Download and drop ```YourLibrary.swift``` in your project.  
2. Congratulations!  

## Usage example

```swift
import EZSwiftExtensions
ez.detectScreenShot { () -> () in
    print("User took a screen shot")
}
```

## Meta

Lee Yong Kien – ken.lyk@hotmail.com
