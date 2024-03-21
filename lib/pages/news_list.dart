import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kesehatan/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:kesehatan/pages/news_detail.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:kesehatan/utils/constant.dart';

class NewsListPage extends StatefulWidget {
  final String? q;
  const NewsListPage({super.key, this.q});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLoading = true;
  List<News> news = [];
  TextEditingController searchController = TextEditingController();

  Future<void> getNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.get(Uri.parse("$url/news/"));
      setState(() {
        isLoading = false;
        news.clear();
        news.addAll(newsFromJson(res.body));
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  Future<void> searchNews(String q) async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.post(
        Uri.parse("$url/news/search"),
        body: {'q': q},
      );
      setState(() {
        isLoading = false;
        news.clear();
        news.addAll(newsFromJson(res.body));
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: searchController,
              style: regular16pt,
              onSubmitted: (value) {
                searchNews(value);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(4.0),
                suffixIcon: Icon(
                  Icons.search_rounded,
                  color: textGrey,
                ),
                hintText: 'Search News',
                hintStyle: heading6.copyWith(color: textGrey),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : news.isEmpty
                    ? Center(
                        child: Text(
                          'No data found',
                          style: heading2,
                        ),
                      )
                    : ListView.builder(
                        itemCount: news.length,
                        itemBuilder: (BuildContext context, int index) {
                          News data = news[index];
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                NewsDetailsPage(data)));
                                  },
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              "$url/images/${data.image}",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                            title: Text(
                                              data.title,
                                              style: heading6,
                                            ),
                                            subtitle: Text(
                                              data.body,
                                              maxLines: 2,
                                              style: regular16pt.copyWith(
                                                  fontSize: 14,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ))
                                      ],
                                    ),
                                  )));
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
