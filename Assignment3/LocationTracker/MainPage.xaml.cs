using Microsoft.Maui.Controls.Maps;
using Microsoft.Maui.Maps;

namespace LocationTracker;

/// <summary>
/// Main page of the Location Tracker app.
/// Displays a map with location history visualized as a heat map (path + pins).
/// </summary>
public partial class MainPage : ContentPage
{
    private readonly LocationService _locationService;
    private readonly DatabaseService _databaseService;
    private Polyline? _currentPolyline;

    public MainPage(LocationService locationService, DatabaseService databaseService)
    {
        InitializeComponent();
        _locationService = locationService;
        _databaseService = databaseService;
        _locationService.LocationChanged += OnLocationChanged;
        
        // Load history after the page is fully loaded
        Loaded += async (s, e) => await LoadHistoryAsync();
    }

    /// <summary>
    /// Loads historical location data from the database and displays it on the map.
    /// </summary>
    private async Task LoadHistoryAsync()
    {
        try
        {
            var locations = await _databaseService.GetAllLocationsAsync();

            if (locations.Count == 0)
                return;

            foreach (var loc in locations)
            {
                AddPinToMap(loc);
            }

            // Center map on the last known location
            var lastLocation = locations.Last();
            map.MoveToRegion(MapSpan.FromCenterAndRadius(
                new Location(lastLocation.Latitude, lastLocation.Longitude),
                Distance.FromKilometers(1)));

            // Draw the initial path
            UpdatePolyline();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Error loading history: {ex.Message}");
        }
    }

    /// <summary>
    /// Adds a pin marker for a location on the map.
    /// </summary>
    private void AddPinToMap(LocationData location)
    {
        var pin = new Pin
        {
            Label = $"Lat: {location.Latitude:F4}",
            Location = new Location(location.Latitude, location.Longitude),
            Type = PinType.Place
        };
        map.Pins.Add(pin);
    }

    /// <summary>
    /// Updates the polyline (path) connecting all location pins to visualize the heat map trail.
    /// </summary>
    private void UpdatePolyline()
    {
        if (map.Pins.Count < 2)
            return;

        // Remove old polyline
        if (_currentPolyline != null)
            map.MapElements.Remove(_currentPolyline);

        // Create new polyline connecting all pins
        _currentPolyline = new Polyline
        {
            StrokeColor = Colors.Red,
            StrokeWidth = 5
        };

        foreach (var pin in map.Pins)
        {
            _currentPolyline.Geopath.Add(pin.Location);
        }

        map.MapElements.Add(_currentPolyline);
    }

    /// <summary>
    /// Handles real-time location updates from the LocationService.
    /// </summary>
    private void OnLocationChanged(object? sender, LocationData location)
    {
        MainThread.BeginInvokeOnMainThread(() =>
        {
            AddPinToMap(location);
            UpdatePolyline();
            
            // Keep map centered on current location
            map.MoveToRegion(MapSpan.FromCenterAndRadius(
                new Location(location.Latitude, location.Longitude),
                Distance.FromKilometers(0.5)));
        });
    }

    /// <summary>
    /// Starts location tracking after requesting permissions.
    /// </summary>
    private async void OnStartTrackingClicked(object sender, EventArgs e)
    {
        try
        {
            Console.WriteLine("DEBUG: Start Tracking Clicked");
            lblStatus.Text = "Status: Checking Permissions...";
            
            var status = await Permissions.CheckStatusAsync<Permissions.LocationWhenInUse>();
            Console.WriteLine($"DEBUG: Permission status: {status}");

            if (status != PermissionStatus.Granted)
            {
                Console.WriteLine("DEBUG: Requesting permission...");
                status = await Permissions.RequestAsync<Permissions.LocationWhenInUse>();
                Console.WriteLine($"DEBUG: New permission status: {status}");
            }

            if (status == PermissionStatus.Granted)
            {
                lblStatus.Text = "Status: Waiting for GPS...";
                Console.WriteLine("DEBUG: Starting LocationService...");
                // Name corrected to match LocationService definition
                await _locationService.StartTrackingAsync();
                
                btnStart.IsEnabled = false;
                btnStop.IsEnabled = true;
                lblStatus.Text = "Status: Tracking";
                Console.WriteLine("DEBUG: Tracking started successfully");
            }
            else
            {
                lblStatus.Text = "Status: Permission Denied";
                await DisplayAlert("Permission Denied", 
                    "Location permission is required to track your position.", "OK");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"DEBUG: Error in OnStartTrackingClicked: {ex}");
            lblStatus.Text = $"Status: Error - {ex.Message}";
        }
    }

    /// <summary>
    /// Stops location tracking.
    /// </summary>
    private void OnStopTrackingClicked(object sender, EventArgs e)
    {
        _locationService.StopTracking();
        btnStart.IsEnabled = true;
        btnStop.IsEnabled = false;
        lblStatus.Text = "Status: Stopped";
    }
}
