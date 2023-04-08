// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  List<String> countries = [
    'Select a Country',
    'India',
    'Andorra',
    'United States',
    'China'
  ];

  late String _selectedCountry;
  NewsProvider() {
    _selectedCountry = countries[0];
  }

  String get selectedCountry => _selectedCountry;
  List<String> get getCountries => countries;
  void setSelectedCountry(String country) {
    _selectedCountry = country;
    notifyListeners();
  }
}
