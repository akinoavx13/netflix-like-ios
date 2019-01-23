# Netflix like

[![Language](https://img.shields.io/badge/Swift-4.2-brightgreen.svg)](http://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.0-brightgreen.svg)](https://developer.apple.com/download/more/)

![Demo](Demo.gif)

## 📖 Project description
Application to demonstrate how I develop an iOS App in 5 days

## 🔧 Installation
1. `git clone git@github.com:mmaheo/netflix-like-ios.git`
2. Run `carthage update --platform ios`

## 🌲 Branches
* `master` - with the latest version submitted for App Store release.
* `develop` - where the actual work is done.

## 🛒 Dependencies

- [Springbok](https://github.com/nodes-ios/Springbok)

## ⚠️ Things to know
* I use fastlane to automatic code sign-in, deploy to testflight and app store.
* I use VIPER architecture.
* I use [SwiftLint](https://github.com/realm/SwiftLint) to enforce Swift style and conventions.

## 💻 Developers
* Maxime Maheo
    * [GitHub](https://github.com/mmaheo)
    * [LinkedIn](https://www.linkedin.com/in/maxime-maheo-120907a8/)
    * Feel free to send me a message on LinkedIn if you want to discuss about our future 🤝

## 🌄 How to generate demo Gif
1. `brew install ffmpeg`
2. `brew install gifsicle`
3. Record your demo `xcrun simctl io booted recordVideo Demo.mov`
4. Convert your .mov into .gif `ffmpeg -i tm.mov -s 462x1000 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=5 > Demo.gif`