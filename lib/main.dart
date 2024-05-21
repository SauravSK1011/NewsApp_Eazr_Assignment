import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappassignment/Presentation/Home/HomeScreen.dart';
import 'package:newsappassignment/Services/News/news_services_bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsServicesBlocBloc()..add(loadNewsServicesEvent("Top Headings")),
          ),
        ],
        child: MaterialApp(
          title: 'NewsApp Eazr Assignment',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen(),
        ));
  }
}
