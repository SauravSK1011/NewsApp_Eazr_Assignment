import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:newsappassignment/Models/NewsModel.dart';
import 'package:http/http.dart' as http;

part 'news_services_bloc_event.dart';
part 'news_services_bloc_state.dart';

class NewsServicesBlocBloc
    extends Bloc<NewsServicesBlocEvent, NewsServicesBlocState> {
  NewsServicesBlocBloc() : super(NewsServicesBlocInitial()) {
    on<NewsServicesBlocEvent>((event, emit) async {
      if (event is loadNewsServicesEvent) {
        String baseUrl =
            'https://newsapi.org/v2/everything?q=${event.query}&apiKey=726d346b6f014f24ae6a429610135e52';

        try {
          final response = await http.get(Uri.parse(baseUrl));

          if (response.statusCode == 200) {
            final jsonData = json.decode(response.body);
            emit(NewsServicesBlocsuccess(NewsModel.fromJson(jsonData)));
          } else {
            Fluttertoast.showToast(
                msg: "Failed to fetch news: ${response.statusCode}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            emit(NewsServicesBlocfailure(
                "Failed to fetch news: ${response.statusCode}"));
          }
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Exception while fetching news: $e",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          emit(NewsServicesBlocfailure("Exception while fetching news: $e"));
        }
      }
    });
  }
}
