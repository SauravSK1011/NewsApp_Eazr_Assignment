import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsappassignment/Models/ArticleModel.dart';
import 'package:newsappassignment/Models/NewsModel.dart';
import 'package:newsappassignment/Widgets/ArticleDetail.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key, this.news, this.initialind = 1});
  final NewsModel? news;
  final int initialind;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool isVisible = true;
  List<Widget> articaltoshow = [];
  @override
  void initState() {
    getdata();
    Timer(Duration(seconds: 5), () {
      setState(() {
        isVisible = false;
      });
    });
    super.initState();
  }

  getdata() {
    articaltoshow = [];
    for (var i = 0; i < widget.news!.articles!.length; i++) {
      articaltoshow.add(ArticleDetailPage(article: widget.news!.articles![i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    PageController controller = PageController(initialPage: widget.initialind);

    return Scaffold(
      body: Stack(
        children: [
          PageView(controller: controller,
            scrollDirection: Axis.vertical,
            children: articaltoshow,
          ),
          Visibility(
            visible: isVisible,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenheight / 10),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Scroll Down to see More ")),
                )),
          )
        ],
      ),
    );
  }
}
