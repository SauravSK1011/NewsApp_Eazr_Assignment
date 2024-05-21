import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:newsappassignment/Models/NewsModel.dart';

class NewsServices {
  static Future<NewsModel?> fetchNews(String quarry) async {
    String baseUrl =
        'https://newsapi.org/v2/everything?q=$quarry&apiKey=726d346b6f014f24ae6a429610135e52';

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NewsModel.fromJson(jsonData);
      } else {
        Fluttertoast.showToast(
        msg: "Failed to fetch news: ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
        return null;
      }
    } catch (e) {
              Fluttertoast.showToast(
        msg: "Exception while fetching news: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

      return null;
    }
  }
}
