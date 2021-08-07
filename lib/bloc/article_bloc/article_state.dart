import 'package:bloc_app_dynamic/data/modals/articles_modal.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ArticleLoadedState extends ArticleState {
  List<Article> articles;
  ArticleLoadedState({required this.articles});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ArticleErrorState extends ArticleState {
  String message;

  ArticleErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
