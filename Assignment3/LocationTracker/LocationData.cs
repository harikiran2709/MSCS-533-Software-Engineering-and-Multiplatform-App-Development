using SQLite;

namespace LocationTracker;

/// <summary>
/// Represents a location data point stored in the SQLite database.
/// </summary>
public class LocationData
{
    [PrimaryKey, AutoIncrement]
    public int Id { get; set; }
    
    public double Latitude { get; set; }
    
    public double Longitude { get; set; }
    
    public DateTime Timestamp { get; set; }
}
