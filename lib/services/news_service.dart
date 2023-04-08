import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news.dart';

class NewsService {
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines';
  final String _apiKey = 'your_api_key';

  Future<List<News>> getNews({String? country}) async {
    var url = '$_baseUrl?apiKey=$_apiKey';
    if (country != null) {
      url += '&country=$country';
    }
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var newsJson = json['articles'];
      return List<News>.from(newsJson.map((news) => News.fromJson(news)));
    } else {
      throw Exception('Failed to load news');
    }
  }
}
