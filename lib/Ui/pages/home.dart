import 'package:bloc_app_dynamic/Ui/pages/category.dart';
import 'package:bloc_app_dynamic/Ui/pages/news.dart';
import 'package:bloc_app_dynamic/bloc/article_bloc/article_bloc.dart';
import 'package:bloc_app_dynamic/bloc/article_bloc/article_event.dart';
import 'package:bloc_app_dynamic/bloc/article_bloc/article_state.dart';
import 'package:bloc_app_dynamic/constants/app_constants.dart';
import 'package:bloc_app_dynamic/data/modals/articles_modal.dart';
import 'package:bloc_app_dynamic/data/repositories/article_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> category = [
    "Technology",
    "Business",
    "Entertainment",
    "Health",
    "Science",
    "Sport"
  ];
  @override
  Widget build(BuildContext context) {
    ArticleBloc articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.appName),
        actions: [
          IconButton(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: AppConstant.appName,
                  applicationIcon: AppConstant.logo,
                  applicationVersion: AppConstant.appVersion,
                  applicationLegalese: AppConstant.about,
                );
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state is ArticleErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Column(
          children: [
            buildCategoryView(category, context),
            Expanded(
              child: BlocBuilder<ArticleBloc, ArticleState>(
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
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildLaoding() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

Widget buildArticleList(List<Article> articles) {
  return ListView.builder(
      itemCount: articles.length,
      shrinkWrap: true,
      primary: false,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
            elevation: 3,
            margin: EdgeInsets.all(10),
            child: InkWell(
              splashColor: Colors.blue,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => News(article: articles[index])));
              },
              child: Container(
                margin: EdgeInsets.all(13),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: articles[index].urlToImage != null
                            ? Image.network(
                                articles[index].urlToImage,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS96rNQGyIc4IwVxc6g6bK966mvXXfPW_RuJmyMHhpJr0zfpTj6Y3Bx8D_B5qph4YuG5o8&usqp=CAU",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(articles[index].title,
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            articles[index].description != null
                                ? articles[index].description
                                : "",
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      });
}

Widget buildCategoryView(List<String> category, context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    height: MediaQuery.of(context).size.height * 0.1,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: category.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            String categoryVal = category[index].toLowerCase();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (BuildContext context) => ArticleBloc(
                        repository: ArticlesRepositoryImpl(
                            url:
                                "https://newsapi.org/v2/top-headlines?country=in&category=${categoryVal}&apiKey=c5dd60095c67449cb216d1e7415389f2")),
                    child: Category(title: category[index]),
                  ),
                ));
          },
          child: Container(
              margin: EdgeInsets.only(right: 6),
              child: Chip(
                  backgroundColor: Colors.blue,
                  label: Text(
                    category[index],
                    style: TextStyle(color: Colors.white),
                  ))),
        );
      },
    ),
  );
}

Widget buildAboutModal() {
  return AlertDialog(
    content: Container(
      child: Column(
        children: [
          RichText(
              text: TextSpan(text: "Made By", children: [
            TextSpan(
                text: '@codeking5',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ])),
        ],
      ),
    ),
  );
}
