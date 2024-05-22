import 'package:flutter/material.dart';
import 'package:newsappassignment/Models/ArticleModel.dart';
import 'package:newsappassignment/Services/Save/SaveManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui; // Import the dart:ui library

class ArticleDetailPage extends StatefulWidget {
  final Article article;

  ArticleDetailPage({required this.article});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool isBookmarked = false;
  late SharedPreferences prefs;

  initpref() async {
    prefs = await SharedPreferences.getInstance();
    isBookmarked = await ArticleManager().containsArticle(widget.article);
    setState(() {});
  }

  @override
  void initState() {
    initpref();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                if (widget.article.urlToImage != null)
                  Image.network(
                    height: screenheight / 2.5,
                    width: screenwidth,
                    fit: BoxFit.fill,
                    widget.article.urlToImage!,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Image.network(
                          "https://icons.veryicon.com/png/o/education-technology/alibaba-big-data-oneui/image-loading-failed-02.png");
                    },
                  ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.article.title ?? 'No Title',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By ${widget.article.author != null ? (widget.article.author!.length > 25 ? '${widget.article.author!.substring(0, 25)}...' : widget.article.author!) : 'Unknown'}',
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        widget.article.publishedAt ?? '',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.article.description != null
                        ? (widget.article.description!.length > 250
                            ? '${widget.article.description!.substring(0, 250)}...'
                            : widget.article.description!)
                        : 'No Description',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(
                        100), // half the width/height makes it circular
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                            print(isBookmarked);
                            !isBookmarked
                                ? ArticleManager().removeArticle(widget.article)
                                : ArticleManager().addArticle(widget.article);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isBookmarked
                                  ? 'Article Bookmarked'
                                  : 'Bookmark Removed'),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (widget.article.url != null) {}
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (widget.article.urlToImage != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Stack(
                    children: [
                      // Background image
                      Image.network(
                        widget.article.urlToImage!,
                        width: double.infinity,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      // Blur effect
                      BackdropFilter(
                        filter:
                            ui.ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      const Center(
                          child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Tap to Know More',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
