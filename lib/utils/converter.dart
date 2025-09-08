/// Utility class containing conversion logic for different unit types
class UnitConverter {
  /// Converts a value from one unit to another unit of the same category
  static double convert(double value, String from, String to) {
    // Distance conversion factors - all values relative to meters
    Map<String, double> toMeters = {
      'meters': 1.0,
      'kilometers': 1000.0,
      'feet': 0.3048,
      'inches': 0.0254,
      'miles': 1609.344,
    };
    
    Map<String, double> fromMeters = {
      'meters': 1.0,
      'kilometers': 1/1000.0,
      'feet': 1/0.3048,
      'inches': 1/0.0254,
      'miles': 1/1609.344,
    };

    // Weight conversion factors - all values relative to kilograms
    Map<String, double> toKg = {
      'kilograms': 1.0,
      'grams': 0.001,
      'pounds': 0.453592,
      'ounces': 0.0283495,
    };
    
    Map<String, double> fromKg = {
      'kilograms': 1.0,
      'grams': 1000.0,
      'pounds': 1/0.453592,
      'ounces': 1/0.0283495,
    };

    // Temperature conversion formulas
    if (from == 'celsius' && to == 'fahrenheit') return value * 9/5 + 32;
    if (from == 'fahrenheit' && to == 'celsius') return (value - 32) * 5/9;
    if (from == 'celsius' && to == 'kelvin') return value + 273.15;
    if (from == 'kelvin' && to == 'celsius') return value - 273.15;
    if (from == 'fahrenheit' && to == 'kelvin') return (value - 32) * 5/9 + 273.15;
    if (from == 'kelvin' && to == 'fahrenheit') return (value - 273.15) * 9/5 + 32;

    // Distance conversion using base unit (meters)
    if (toMeters.containsKey(from) && fromMeters.containsKey(to)) {
      double meters = value * toMeters[from]!;
      return meters * fromMeters[to]!;
    }

    // Weight conversion using base unit (kilograms)
    if (toKg.containsKey(from) && fromKg.containsKey(to)) {
      double kg = value * toKg[from]!;
      return kg * fromKg[to]!;
    }

    return value;
  }
}