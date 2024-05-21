import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsappassignment/Models/NewsModel.dart';

Widget newscard(Article news) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Card(elevation: 25,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(news.urlToImage??"https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=600")),
            Text(
              "${news.title!.substring(0, news.title!.length < 60 ? news.title!.length : 60)}...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}
