import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class NewsItem extends StatefulWidget {

    NewsItem({required this.title,required this.author,required this.uri,});
   String title ;
   String author ;
   String uri ;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  late Uri _url;
  @override
  Widget build(BuildContext context) {
    _url = Uri.parse(widget.uri);
    return InkWell(
      onTap: (){
        _launchUrl();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                          widget.title,
                          style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Colors.black87),
                        ),
            ),

            Text(
              "source: ${widget.author}",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
