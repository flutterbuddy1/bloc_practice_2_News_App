import 'package:bloc_app_dynamic/bloc/article_bloc/article_bloc.dart';
import 'package:bloc_app_dynamic/data/repositories/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Ui/pages/home.dart';
import 'constants/app_constants.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: BlocProvider(
        create: (BuildContext context) => ArticleBloc(
            repository: ArticlesRepositoryImpl(url: AppConstant.url)),
        child: Home(),
      ),
    );
  }
}
