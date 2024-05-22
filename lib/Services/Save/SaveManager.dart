import 'dart:convert';
import 'package:newsappassignment/Models/ArticleModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleManager {
  static const _key = 'articles';

  Future<void> addArticle(Article article) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> articles = prefs.getStringList(_key) ?? [];
    
    articles.add(json.encode(article.toJson()));
    
    await prefs.setStringList(_key, articles);
  }

  Future<void> removeArticle(Article article) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> articles = prefs.getStringList(_key) ?? [];
    
    articles.removeWhere((articleJson) {
      final articleData = json.decode(articleJson);
      return articleData['title'] == article.title && articleData['publishedAt'] == article.publishedAt;
    });
    
    await prefs.setStringList(_key, articles);
  }

  Future<List<Article>> getArticles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> articles = prefs.getStringList(_key) ?? [];
    
    return articles.map((articleJson) {
      final articleData = json.decode(articleJson);
      return Article.fromJson(articleData);
    }).toList();
  }
  Future<bool> containsArticle(Article article) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> articles = prefs.getStringList(_key) ?? [];

    return articles.any((articleJson) {
      final articleData = json.decode(articleJson);
      return articleData['title'] == article.title && articleData['publishedAt'] == article.publishedAt;
    });
  }

}
