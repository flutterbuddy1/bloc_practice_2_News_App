import 'package:bloc_app_dynamic/data/modals/articles_modal.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class News extends StatefulWidget {
  News({Key? key, required this.article}) : super(key: key);
  Article article;
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  int progressVal = 0;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.article.title,
          maxLines: 1,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? Container(
                  height: 3,
                  width: progressVal * 10,
                  color: Colors.red,
                )
              : SizedBox(),
          Expanded(
            child: WebView(
              initialUrl: widget.article.url,
              onProgress: (progress) {
                setState(() {
                  progressVal = progress;
                });
              },
              onPageFinished: (val) => setState(() {
                isLoading = false;
              }),
            ),
          ),
        ],
      ),
    );
  }
}
