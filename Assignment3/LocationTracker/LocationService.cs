namespace LocationTracker;

/// <summary>
/// Service for tracking user location and saving data to the database.
/// Periodically captures GPS coordinates and raises events for UI updates.
/// </summary>
public class LocationService
{
    private readonly DatabaseService _databaseService;
    private CancellationTokenSource? _cancellationTokenSource;

    /// <summary>
    /// Event raised when a new location is captured.
    /// </summary>
    public event EventHandler<LocationData>? LocationChanged;

    public LocationService(DatabaseService databaseService)
    {
        _databaseService = databaseService;
    }

    /// <summary>
    /// Starts continuous location tracking with 5-second intervals.
    /// </summary>
    public async Task StartTrackingAsync()
    {
        try
        {
            var request = new GeolocationRequest(GeolocationAccuracy.High, TimeSpan.FromSeconds(10));
            _cancellationTokenSource = new CancellationTokenSource();

            while (!_cancellationTokenSource.Token.IsCancellationRequested)
            {
                var location = await Geolocation.Default.GetLocationAsync(request, _cancellationTokenSource.Token);

                if (location != null)
                {
                    var locationData = new LocationData
                    {
                        Latitude = location.Latitude,
                        Longitude = location.Longitude,
                        Timestamp = DateTime.Now
                    };

                    await _databaseService.AddLocationAsync(locationData);
                    LocationChanged?.Invoke(this, locationData);
                }

                await Task.Delay(5000, _cancellationTokenSource.Token);
            }
        }
        catch (OperationCanceledException)
        {
            // Expected when StopTracking is called
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Location tracking error: {ex.Message}");
        }
    }

    /// <summary>
    /// Stops the location tracking.
    /// </summary>
    public void StopTracking()
    {
        _cancellationTokenSource?.Cancel();
    }
}
