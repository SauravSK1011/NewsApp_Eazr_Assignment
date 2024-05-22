import 'package:newsappassignment/Models/ArticleModel.dart';

class NewsModel {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: (json['articles'] as List<dynamic>?)
          ?.map((article) => Article.fromJson(article))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles?.map((article) => article.toJson()).toList(),
    };
  }
}



