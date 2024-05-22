import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappassignment/Services/News/news_services_bloc_bloc.dart';
import 'package:newsappassignment/Widgets/AppBar.dart';
import 'package:newsappassignment/Widgets/NewsCard.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});
  final String category;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  double showcount = 0.1;
  final ScrollController sc = ScrollController();

  @override
  void initState() {
    sc.addListener(scrolllissner);
    super.initState();
    loads();
  }

  bool load = false;
  loads() async {
    print(widget.category);
    context
        .read<NewsServicesBlocBloc>()
        .add(loadNewsServicesEvent(widget.category));
    Timer(Duration(seconds: 2), () {
      setState(() {
        load = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(title: appBar(context),),
        body: Column(
          children: [
            Text(
              widget.category,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            load
                ? Container(
                    height: MediaQuery.of(context).size.height / 1.15,
                    width: MediaQuery.of(context).size.width,
                    child: BlocBuilder<NewsServicesBlocBloc,
                        NewsServicesBlocState>(builder: (context, state) {
                      if (state is NewsServicesBlocsuccess) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              controller: sc,
                              itemCount: min(
                                  state.newsServices.articles!.length,
                                  (state.newsServices.articles!.length *
                                          showcount)
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
                    }),
                  )
                : Center(child: CircularProgressIndicator()),
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
