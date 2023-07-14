import 'package:flutter/material.dart';
import '../components/article_row.dart';
import '../api/index.dart';
import '../model/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleShow extends StatefulWidget {
  const ArticleShow({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _ArticleShowState createState() => _ArticleShowState();
}

class _ArticleShowState extends State<ArticleShow> {
  ArticleDetail? article;
  void setArticle(Map articleJson) {
    setState(() {
      article = ArticleDetail.fromJson(articleJson);
    });
  }

  @override
  void initState() {
    super.initState();
    Api api = Api(setter: setArticle);
    api.getArticle(widget.id);
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(article!.url);
    if (_url != null && !await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (article == null) {
      return const Center(child: Text("読込中......."));
    } else {
      return ListView(
        children: [
          Container(
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      article!.author,
                    ),
                  ),
                  Container(
                      child: Text(
                    article!.title,
                    style: const TextStyle(fontSize: 24),
                  )),
                  Container(
                      width: 150,
                      child: Row(
                        children: [
                          ...article!.tags.map((e) => Tag(tagName: e["name"])),
                          Text("作成日時: ${article!.createdAt}"),
                        ],
                      ))
                ],
              )),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("一覧へ戻る")),
          TextButton(
              onPressed: () => _launchUrl(), child: const Text("記事へジャンプ")),
          Text(
            article!.body,
            overflow: TextOverflow.clip,
          ),
        ],
      );
    }
  }
}
