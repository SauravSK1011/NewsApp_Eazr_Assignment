part of 'news_services_bloc_bloc.dart';

@immutable
abstract class NewsServicesBlocState {}

class NewsServicesBlocInitial extends NewsServicesBlocState {}
class NewsServicesBlocLoading extends NewsServicesBlocState {}
class NewsServicesBlocsuccess extends NewsServicesBlocState {  final NewsModel newsServices;  

  NewsServicesBlocsuccess(this.newsServices);
}
class NewsServicesBlocfailure extends NewsServicesBlocState {  final String error;

  NewsServicesBlocfailure(this.error);
}
