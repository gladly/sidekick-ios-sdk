# Gladly Sidekick SDK

The Gladly iOS SDK makes it quick and easy to build a messaging experience in your iOS app. We provide powerful and customizable UI screens and elements that can be used out-of-the-box to connect with your users.

![screenshot of chat conversation](ChatExample.png)

## Documentation
API documentation can be found at [https://developer.gladly.com/ios-sdk/](https://developer.gladly.com/ios-sdk/)

## Example application
To get an idea of how to work with the SDK an example application can be found [here](https://github.com/gladly/sidekick-ios-sdk/tree/master/Example).
1. Clone this repository.
1. Open the Example project in Xcode (version > 11.0).
1. Drag in the latest release of the SDK as a dependency.
1. Replace the `appId` in `AppDelegate.swift` with a value given to you by Gladly.

## Releases
Releases of the SDK can be found under the [releases](https://github.com/gladly/sidekick-ios-sdk/releases) tab.

## FAQ
What are the differences between the two release bundles?
  - `GladlySidekick.framework.<version>.zip` contains code for both ARM and x84_64 architectures so it can be run on the physical iPhone and in the XCode simulator respectively. However, unused architectures may need to be removed before deploying to the App Store.
  - `GladlySidekick.xcframework.<version>.zip` is supported by XCode 11 and up. It is the latest code distribution format and can simplify the process of developing and releasing applications by adding support for multiple platforms and architectures. There is also no need to strip unused architectures when deploying to the App Store.

Which release bundle should I use?  
  - If you are developing using XCode 11 or newer, we recommend using `GladlySidekick.xcframework.<version>.zip`.

## Licence
[See license](https://github.com/gladly/sidekick-ios-sdk/tree/master/LICENSE.md)
