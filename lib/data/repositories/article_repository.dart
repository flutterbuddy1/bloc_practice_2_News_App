import 'dart:convert';

import 'package:bloc_app_dynamic/constants/app_constants.dart';
import 'package:bloc_app_dynamic/data/modals/articles_modal.dart';

import 'package:http/http.dart' as http;

abstract class ArticlesRepository {
  Future<List<Article>> getArticles();
}

class ArticlesRepositoryImpl implements ArticlesRepository {
  String url;
  ArticlesRepositoryImpl({required this.url});
  @override
  Future<List<Article>> getArticles() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Article> articles = articlesFromJson(response.body).articles;
      return articles;
    } else {
      return <Article>[];
    }
  }
}
