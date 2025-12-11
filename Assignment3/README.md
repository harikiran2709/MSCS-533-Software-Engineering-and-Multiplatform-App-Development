# Assignment 3: Location Tracker

A .NET MAUI app that tracks GPS location, saves to SQLite, and displays as a heat map.

## Features
- Real-time GPS tracking
- SQLite database persistence
- Interactive map with heat map visualization
- Start/Stop tracking controls

## 🔧 Technical Details

### Technology Stack
- **Language**: C# 11
- **Framework**: .NET MAUI 8.0
- **Database**: SQLite3
- **Package Manager**: NuGet

### Prerequisites
- Visual Studio for Mac
- .NET 8 SDK
- iOS Simulator

## Key Files
- **LocationTracker/MainPage.xaml**: Contains the Map control and UI buttons.
- **LocationTracker/LocationService.cs**: Handles geolocation updates.
- **LocationTracker/DatabaseService.cs**: Manages SQLite database connections and queries.
- **LocationTracker/LocationData.cs**: Defines the structure of location data.

## How to Generate the Assignment Output
1.  **Run the App**: Follow the steps above to launch the app on iOS Simulator.
2.  **Start Tracking**: Click the "Start Tracking" button.
3.  **Simulate Movement**: Use the iOS Simulator's location tools to simulate a route (Simulator menu > Features > Location > City Run).
4.  **Screenshot**: Take a screenshot of the app showing the red path and blue pins.
    *   This screenshot is your required output for the assignment.

## How to Run (The Easy Way) using Terminal

Since you have a local copy of .NET in your folder, use these exact commands.

### 1. Open Terminal
Open your **Terminal** app on your Mac.

### 2. Navigate to the Assignment Folder
Copy and paste this command:
```bash
cd "/Users/harikiran/MSCS-533-Software-Engineering-and-Multiplatform-App-Development/Assignment3"
```

### 3. Run on iPhone Simulator
Copy and paste this command EXACTLY (it uses your local dotnet):
```bash
./dotnet/dotnet build LocationTracker/LocationTracker.csproj -t:Run -f net8.0-ios
```
*Note: This will automatically launch your default iPhone Simulator.*

### 4. How to Generate the Output (Screenshot)
Once the app is running:
1.  **Click "Start Tracking"**.
2.  **Simulate Movement**:
    *   Click on the **Simulator** window.
    *   In the Mac menu bar at the top, select **Features** -> **Location** -> **City Run**.
3.  **Take Screenshot**:
    *   Wait for the red line to appear.
    *   Press `Cmd + Shift + 4`, then tap Spacebar, then click the Simulator window.

