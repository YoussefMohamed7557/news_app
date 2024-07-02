import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/news_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'news_model.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});
  static final String routName = "NewsListPage";

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  @override
  List<NewsModel> data = [];
  @override
  void initState() {
    getResponse();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News List',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: data.length == 0? Center(child: CircularProgressIndicator(),):ListView.separated(
        separatorBuilder: (context, index) => Divider(color: Theme.of(context).primaryColor,height: 2,),
        itemBuilder: (context, index) {
          print("title ${data[index].title}, author: ${data[index]
              .author},url: ${data[index].url},");
          return NewsItem(title: data[index].title,
               author: data[index].author,
              uri: data[index].url);
        },
        itemCount: data.length,
      ),
    );
  }

  getResponse() async {
    print("getting response");
    var url = Uri.https('newsapi.org','/v2/top-headlines',{'country': 'eg', 'apiKey': '5f7de885c3f045cfb63d460f0bb426ed'},);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String responseString =response.body;
      //print(responseString);
      Map<String,dynamic> value = convert.jsonDecode(responseString) as Map<String,dynamic>;
      List articles = value["articles"];
      for(int i=0 ; i<articles.length;i++){
        NewsModel newsModel = NewsModel(title: articles[i]["title"],author:articles[i]["author"],url: articles[i]["url"]);
       // print ("title ${newsModel.title}, author: ${newsModel.author},url: ${newsModel.url}," );
        data.add(newsModel);
      }
      setState(() {});
    }
  }
}
