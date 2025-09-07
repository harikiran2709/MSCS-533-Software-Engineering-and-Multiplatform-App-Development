import 'package:flutter/material.dart';
import '../utils/converter.dart';

/// Main screen widget that provides the user interface for unit conversions
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _valueController = TextEditingController();
  String _fromUnit = 'meters';
  String _toUnit = 'feet';
  String _result = '';

  @override
  void initState() {
    super.initState();
    _valueController.text = '100'; // Default value as shown in assignment
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  /// Performs the unit conversion and updates the result display
  void _performConversion() {
    if (_valueController.text.isEmpty) {
      setState(() => _result = 'Please enter a value');
      return;
    }

    try {
      final value = double.parse(_valueController.text);
      final convertedValue = Converter.convert(value, _fromUnit, _toUnit);
      setState(() {
        _result = '${value.toStringAsFixed(1)} $_fromUnit are ${convertedValue.toStringAsFixed(3)} $_toUnit';
      });
    } catch (e) {
      setState(() => _result = 'Invalid input');
    }
  }

  /// Returns the list of available units based on the current category
  List<String> _getUnits() {
    if (_fromUnit == 'meters' || _fromUnit == 'kilometers' || _fromUnit == 'feet' || 
        _fromUnit == 'inches' || _fromUnit == 'miles') {
      return ['meters', 'kilometers', 'feet', 'inches', 'miles'];
    } else if (_fromUnit == 'kilograms' || _fromUnit == 'grams' || _fromUnit == 'pounds' || _fromUnit == 'ounces') {
      return ['kilograms', 'grams', 'pounds', 'ounces'];
    } else {
      return ['celsius', 'fahrenheit', 'kelvin'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String category) {
              setState(() {
                if (category == 'distance') {
                  _fromUnit = 'meters';
                  _toUnit = 'feet';
                } else if (category == 'weight') {
                  _fromUnit = 'kilograms';
                  _toUnit = 'pounds';
                } else if (category == 'temperature') {
                  _fromUnit = 'celsius';
                  _toUnit = 'fahrenheit';
                }
                _result = '';
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'distance', child: Text('Distance')),
              const PopupMenuItem(value: 'weight', child: Text('Weight')),
              const PopupMenuItem(value: 'temperature', child: Text('Temperature')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Value', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            TextField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            
            const Text('From', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _fromUnit,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              items: _getUnits().map((unit) => DropdownMenuItem(
                value: unit,
                child: Text(unit, style: const TextStyle(color: Colors.blue)),
              )).toList(),
              onChanged: (value) => setState(() => _fromUnit = value!),
            ),
            const SizedBox(height: 24),
            
            const Text('To', style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _toUnit,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2)),
              ),
              items: _getUnits().map((unit) => DropdownMenuItem(
                value: unit,
                child: Text(unit, style: const TextStyle(color: Colors.blue)),
              )).toList(),
              onChanged: (value) => setState(() => _toUnit = value!),
            ),
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _performConversion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.grey[800],
                  elevation: 0,
                ),
                child: const Text('Convert', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 24),
            
            if (_result.isNotEmpty)
              Center(child: Text(_result, style: const TextStyle(fontSize: 16, color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}