import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static Uri makeUri(String url) {
    return Uri.parse(
        'https://newsapi.org/v2/everything?q=$url&apiKey=${dotenv.env['KEY']}');
  }

  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
}
