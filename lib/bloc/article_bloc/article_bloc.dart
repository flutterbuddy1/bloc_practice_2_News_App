import 'package:bloc/bloc.dart';
import 'package:bloc_app_dynamic/bloc/article_bloc/article_event.dart';
import 'package:bloc_app_dynamic/bloc/article_bloc/article_state.dart';
import 'package:bloc_app_dynamic/data/modals/articles_modal.dart';
import 'package:bloc_app_dynamic/data/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticlesRepository repository;
  ArticleBloc({required this.repository}) : super(ArticleInitialState());

  @override
  ArticleState get initialState => ArticleInitialState();

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleEvent) {
      yield ArticleLoadingState();
      try {
        List<Article> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }
}
