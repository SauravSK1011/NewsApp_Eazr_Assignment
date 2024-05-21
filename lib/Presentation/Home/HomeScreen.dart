import 'package:flutter/material.dart';
import 'package:newsappassignment/Services/News/NewsServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  Widget build(BuildContext context) {
    NewsServices.fetchNews("a");
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          const  Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:18.0),
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
                      child: Card(
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(newsCategories[ind]),
                        )),
                      ),
                    );
                  }),
            ),
                      const  Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:18.0),
                  child: Text(
                    "Breaking News",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
