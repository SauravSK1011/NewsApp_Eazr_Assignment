import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsappassignment/Models/ArticleModel.dart';
import 'package:newsappassignment/Models/NewsModel.dart';
import 'package:newsappassignment/Widgets/ArticleDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key, this.news, this.initialind = 1});
  final List<Article>? news;
  final int initialind;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool isVisible = true;
  List<Widget> articaltoshow = [];  Timer? timer;

  @override
  void initState() {
    getdata();
   timer= Timer(Duration(seconds: 5), () {
      setState(() {
        isVisible = false;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  getdata() {
    articaltoshow = [];
    for (var i = 0; i < widget.news!.length; i++) {
      articaltoshow.add(ArticleDetailPage(article: widget.news![i]));
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
