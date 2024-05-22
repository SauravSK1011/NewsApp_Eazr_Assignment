import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsappassignment/Models/ArticleModel.dart';
import 'package:newsappassignment/Models/NewsModel.dart';
import 'package:newsappassignment/Presentation/Article/ArticleScreen.dart';
import 'package:newsappassignment/Presentation/Category/CategoryScreen.dart';

Widget newscard(Article news,double height, double width,BuildContext context,NewsModel allnews,int initialind) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: InkWell(onTap: (){
      Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ArticleScreen(
                                    news: allnews,initialind:initialind
                                  )));
    },
      child: Card(
        elevation: 25,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    news.urlToImage ??
                        "https://images.pexels.com/photos/326055/pexels-photo-326055.jpeg?auto=compress&cs=tinysrgb&w=600",
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Image.network(height: height/4.5,width: width,
                          "https://icons.veryicon.com/png/o/education-technology/alibaba-big-data-oneui/image-loading-failed-02.png");
                    },
                  )),
              Text(
                "${news.title!.substring(0, news.title!.length < 60 ? news.title!.length : 60)}...",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
