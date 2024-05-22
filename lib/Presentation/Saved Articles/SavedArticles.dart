
import 'package:flutter/material.dart';
import 'package:newsappassignment/Models/ArticleModel.dart';
import 'package:newsappassignment/Services/Save/SaveManager.dart';
import 'package:newsappassignment/Widgets/AppBar.dart';
import 'package:newsappassignment/Widgets/NewsCard.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({super.key});

  @override
  State<SavedArticles> createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  void initState() {
    super.initState();
    loads();
  }

  bool load = false;
  List<Article> savedArticles = [];
  loads() async {
    savedArticles = await ArticleManager().getArticles();
    setState(() {
      load = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(appBar: AppBar(title: appBar(context),),
        body: RefreshIndicator(        onRefresh: ()async{
          loads();
        },

          child: Column(
            children: [
             const Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "Saved Articals",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
              Container(
                width: screenwidth,
                height: screenheight - 200,
                child: ListView.builder(
                    itemCount: savedArticles.length,
                    itemBuilder: (context, ind) {
                      return newscard(
                          savedArticles[ind],
                          MediaQuery.of(context).size.height,
                          MediaQuery.of(context).size.width,
                          context,
                          savedArticles,
                          ind);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
