import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappassignment/Presentation/Category/CategoryScreen.dart';
import 'package:newsappassignment/Presentation/Saved%20Articles/SavedArticles.dart';
import 'package:newsappassignment/Services/News/news_services_bloc_bloc.dart';
import 'package:newsappassignment/Widgets/NewsCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double showcount = 0.1;
  final ScrollController sc = ScrollController();

  List<String> newsCategories = [
    'Top Headlines',
    'World News',
    'National News',
    'Local News',
    'Politics',
    'Business',
    'Technology',
    'Science',
    'Health',
    'Sports',
    'Entertainment',
  ];
  @override
  void initState() {
    super.initState();
    sc.addListener(scrolllissner);
  }

  String searchquary = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SavedArticles()));
                  },
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextField(
                    onSubmitted: (v) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CategoryScreen(
                                category: v,
                              )));
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.search),
                          width: 18,
                        )),
                  ),
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newsCategories.length,
                  itemBuilder: (context, ind) {
                    return Container(
                      height: 50,
                      width: 120,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CategoryScreen(
                                    category: newsCategories[ind],
                                  )));
                        },
                        child: Card(
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(newsCategories[ind]),
                          )),
                        ),
                      ),
                    );
                  }),
            ),
            const Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "Breaking News",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            BlocBuilder<NewsServicesBlocBloc, NewsServicesBlocState>(
                builder: (context, state) {
              if (state is NewsServicesBlocsuccess) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      controller: sc,
                      itemCount: min(
                          state.newsServices.articles!.length,
                          (state.newsServices.articles!.length * showcount)
                              .toInt()),
                      itemBuilder: (context, ind) {
                        return newscard(
                            state.newsServices.articles![ind],
                            MediaQuery.of(context).size.height,
                            MediaQuery.of(context).size.width,
                            context,
                            state.newsServices.articles!,
                            ind);
                      }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })
          ],
        ),
      ),
    );
  }

  void scrolllissner() {
    if (sc.position.pixels == sc.position.maxScrollExtent) {
      if (showcount < 1) {
        setState(() {
          showcount = showcount + 0.1;
        });
      }
    }
  }
}
