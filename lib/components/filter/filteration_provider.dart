import 'package:flutter/material.dart';

class FilterationProvider extends ChangeNotifier{
  // Track the selected filters as a list of booleans
  List<bool> _selectedFilters;

  FilterationProvider(int filterCount)
      : _selectedFilters = List.generate(filterCount, (index) => false);

  // Getter for selected filters
  List<bool> get selectedFilters => _selectedFilters;

  // Toggle filter selection
  void toggleFilter(int index) {
    _selectedFilters[index] = !_selectedFilters[index];
    notifyListeners(); // Notify listeners to update the UI
  }

  // Reset all filters to false
  void resetFilters() {
    _selectedFilters = List.generate(_selectedFilters.length, (index) => false);
    notifyListeners();
  }

  // Get applied filters (selected filter options)
  List<String> getAppliedFilters(List<String> filterOptions) {
    List<String> appliedFilters = [];
    for (int i = 0; i < _selectedFilters.length; i++) {
      if (_selectedFilters[i]) {
        appliedFilters.add(filterOptions[i]);
      }
    }
    return appliedFilters;
  }
}