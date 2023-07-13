import 'package:http/http.dart' as http;
import '../model/article.dart';
import 'dart:convert';
import '../env.dart';

class Api {
  final Function setter;

  const Api({required this.setter});

  Future<void> getArticles() async {
    List articleJson = await fetchArticles();
    setter(articleJson);
  }

  Future<List> fetchArticles() async {
    const headers = {'Authorization': 'Bearer $qiita_token'};
    const url = "https://qiita.com";
    const path = "/api/v2/items";
    try {
      final req = await http.get(Uri.parse(url + path), headers: headers);
      final res = jsonDecode(req.body);

      final List<Map> newArticleRowLest = List<Map>.from(res);
      return newArticleRowLest;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Map> fetchArticle(String id) async {
    const headers = {'Authorization': 'Bearer $qiita_token'};
    const url = "https://qiita.com";
    final path = "/api/v2/items/$id";
    try {
      final req = await http.get(Uri.parse(url + path), headers: headers);
      final res = jsonDecode(req.body);
      final Map article = res;
      return article;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<void> getArticle(String id) async {
    Map article = await fetchArticle(id);
    setter(article);
  }
}
