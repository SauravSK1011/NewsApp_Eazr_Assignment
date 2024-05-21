import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsappassignment/Models/NewsModel.dart';

Widget newscard(Article news) {
  return Card(
    child: Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(news.urlToImage!)),
        Text(
          news.title!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
