import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kesehatan/models/news.dart';
import 'package:kesehatan/pages/login.dart';
import 'package:intl/intl.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  Future<List<News>?> getBerita() async {
    try {
      // http.Response res = await http.get(Uri.parse('$url/getBerita.php'));
      // return beritaFromJson(res.body).data;
      // String json = await DefaultAssetBundle.of(context)
      //     .loadString('/assets/berita_dummy.json');
      List<News> data = [
        News(
          newsId: 1,
          title: "lorem",
          body: "lorem ipsum",
          image: "logo.jpg",
          date: DateTime.now(),
        ),
        News(
          newsId: 1,
          title: "lorem",
          body: "lorem ipsum",
          image: "logo.jpg",
          date: DateTime.now(),
        ),
        News(
          newsId: 1,
          title: "lorem",
          body: "lorem ipsum",
          image: "logo.jpg",
          date: DateTime.now(),
        ),
      ];
      return data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Berita"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                });
              },
              icon: const Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: FutureBuilder(
        future: getBerita(),
        builder: (BuildContext context, AsyncSnapshot<List<News>?> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                News? data = snapshot.data?[index];
                return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BeritaDetails(data)));
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'images/logo_app.jpg',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              ListTile(
                                  title: Text(
                                    data!.title,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    data.body,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ))
                            ],
                          ),
                        )));
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class BeritaDetails extends StatelessWidget {
  final News? data;
  const BeritaDetails(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Berita"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "images/logo_app.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data!.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(
              DateFormat().format(data!.date),
            ),
            trailing: const Icon(
              Icons.star,
              color: Colors.red,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            child: Text(
              data!.body,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
