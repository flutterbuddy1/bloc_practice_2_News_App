import 'package:bloc_app_dynamic/bloc/article_bloc/article_bloc.dart';
import 'package:bloc_app_dynamic/bloc/article_bloc/article_event.dart';
import 'package:bloc_app_dynamic/bloc/article_bloc/article_state.dart';
import 'package:bloc_app_dynamic/data/repositories/article_repository.dart';
import 'package:bloc_app_dynamic/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class Category extends StatefulWidget {
  Category({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleInitialState) {
            return buildLaoding();
          } else if (state is ArticleLoadingState) {
            return buildLaoding();
          } else if (state is ArticleLoadedState) {
            return buildArticleList(state.articles);
          } else if (state is ArticleErrorState) {
            return buildErrorUi(state.message);
          } else {
            return buildErrorUi("Something Went Wrong");
          }
        },
      ),
    );
  }
}
