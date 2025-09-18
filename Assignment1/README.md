# Assignment 1: Unit Converter Flutter App

## Overview
A Flutter application that converts between metric and imperial measures for distance, weight, and temperature.

## Features
- **Distance Conversion**: meters, kilometers, feet, inches, miles
- **Weight Conversion**: kilograms, grams, pounds, ounces  
- **Temperature Conversion**: celsius, fahrenheit, kelvin
- **Clean UI**: Material Design with dropdown selectors and conversion button

## Project Structure
```
Assignment1/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── screens/
│   │   └── conversion_screen.dart   # Main UI screen
│   └── utils/
│       └── converter.dart           # Conversion logic
├── ios/                             # iOS platform files
├── pubspec.yaml                     # Dependencies
└── README.md                        # This file
```

## Setup Instructions

### Prerequisites
- Flutter SDK installed
- Xcode (for iOS development)
- iOS Simulator or physical iOS device

### Running the App
1. Navigate to Assignment1 directory:
   ```bash
   cd Assignment1
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run on iOS Simulator:
   ```bash
   flutter run -d ios
   ```

## Key Files
- **lib/main.dart**: App configuration and entry point
- **lib/screens/conversion_screen.dart**: Main UI with conversion interface
- **lib/utils/converter.dart**: Core conversion algorithms
- **ios/Runner/Info.plist**: iOS manifest file

## GitHub Repository
https://github.com/harikiran2709/MSCS-533-Software-Engineering-and-Multiplatform-App-Development

## Author
Harikiran - MSCS 533 Software Engineering and Multiplatform App Development
