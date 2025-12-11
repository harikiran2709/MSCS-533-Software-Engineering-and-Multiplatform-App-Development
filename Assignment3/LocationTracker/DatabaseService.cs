using SQLite;

namespace LocationTracker;

/// Service for managing SQLite database operations.
/// Handles storing and retrieving location data asynchronously.

public class DatabaseService
{
    private SQLiteAsyncConnection? _database;
    /// Initializes the database connection and creates the LocationData table if it doesn't exist.
    private async Task InitializeAsync()
    {
        if (_database is not null)
            return;

        string dbPath = Path.Combine(FileSystem.AppDataDirectory, "LocationData.db3");
        _database = new SQLiteAsyncConnection(dbPath);
        await _database.CreateTableAsync<LocationData>();
    }
    /// Adds a location record to the database.
    public async Task AddLocationAsync(LocationData location)
    {
        await InitializeAsync();
        await _database!.InsertAsync(location);
    }
    /// Retrieves all stored location records from the database.
    public async Task<List<LocationData>> GetAllLocationsAsync()
    {
        await InitializeAsync();
        return await _database!.Table<LocationData>().ToListAsync();
    }
}
