import 'package:flutter/material.dart';
import '../model/article.dart';
import '../pages/article_show.dart';

class ArticleRow extends StatefulWidget {
  ArticleRow({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  _ArticleRowState createState() => _ArticleRowState();
}

class _ArticleRowState extends State<ArticleRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
        child: Column(
          children: [
            Container(
              child: Text(
                widget.article.author,
              ),
            ),
            Container(
                child: Text(
              widget.article.title,
              style: const TextStyle(fontSize: 24),
            )),
            Row(
              children: [
                ...widget.article.tags.map((e) => Tag(tagName: e["name"])),
                Container(
                  child: Text("作成日時: ${widget.article.createdAt}"),
                )
              ],
            ),
            TextButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ArticleShow(id: widget.article.itemId))),
                child: const Text("本文を見る")),
          ],
        ));
  }
}

class Tag extends StatelessWidget {
  const Tag({super.key, required this.tagName});
  final String tagName;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black26,
            border: Border.all(color: Colors.black38, width: 1)),
        child: Text(tagName));
  }
}
