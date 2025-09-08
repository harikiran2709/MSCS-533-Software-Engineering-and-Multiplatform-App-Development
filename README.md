# Unit Converter Flutter App

A Flutter mobile application for converting between different units of measurement.

## Features
- Distance conversions (meters, kilometers, feet, inches, miles)
- Weight conversions (kilograms, grams, pounds, ounces)
- Temperature conversions (Celsius, Fahrenheit, Kelvin)
- Clean Material Design interface

## Project Structure
```
lib/
├── main.dart
├── screens/
│   └── conversion_screen.dart
└── utils/
    └── converter.dart
```

## Setup Instructions

### Prerequisites
- macOS system
- Internet connection

### Step 1: Install Flutter SDK
```bash
brew install --cask flutter
flutter doctor
```

### Step 2: Install Xcode
- Install Xcode from App Store

### Step 3: Install Command Line Tools
```bash
xcode-select --install
sudo xcodebuild -license accept
```

### Step 4: Install CocoaPods
```bash
sudo gem install cocoapods
```

### Step 5: Setup iOS Simulator
- Open Xcode
- Go to: Window → Devices and Simulators → Simulators tab
- Click "+" → Select iPhone 16 Pro → Select iOS 18.5 → Create

### Step 6: Project Setup
```bash
cd /path/to/project
flutter pub get
flutter clean
```

### Step 7: Start Simulator
```bash
open -a Simulator
```

### Step 8: Run App
```bash
# Check available devices
flutter devices

# Run on specific iOS Simulator (use device ID from above)
flutter run -d [DEVICE_ID]

# Example:
flutter run -d 17D214BD-7AEE-4A6B-961B-840CA272D03D
```

## Requirements
- Flutter SDK 3.0.0+
- Xcode for iOS development
- iOS Simulator

## License
MIT License