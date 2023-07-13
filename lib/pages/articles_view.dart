import 'package:flutter/material.dart';
import 'package:qiita_flutter/model/article.dart';
import '../model/article.dart';
import '../api/index.dart';
import '../components/article_row.dart';

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key}) : super(key: key);
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  List articles = [];

  void setArticles(List<Map> articlesJson) {
    setState(() {
      articles.addAll(articlesJson.map((e) => Article.fromJson(e)).toList());
    });
  }

  @override
  void initState() {
    super.initState();
    Api api = Api(setter: setArticles);
    api.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("記事一覧"),
        Expanded(
            child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (BuildContext context, int index) {
            return ArticleRow(article: articles[index]);
          },
        ))
      ],
    );
  }
}
