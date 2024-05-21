part of 'news_services_bloc_bloc.dart';

@immutable
abstract class NewsServicesBlocEvent {}
 
class loadNewsServicesEvent extends NewsServicesBlocEvent{  final String query;

  loadNewsServicesEvent(this.query);
}