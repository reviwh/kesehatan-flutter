import 'package:flutter/material.dart';
import 'package:kesehatan/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:kesehatan/utils/constant.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool isLoading = true;
  List<News> data = [];
  TextEditingController searchController = TextEditingController();

  Future<void> getNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.get(Uri.parse("$url/news/"));
      setState(() {
        isLoading = false;
        data.clear();
        data.addAll(newsFromJson(res.body));
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
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        padding: const EdgeInsets.all(10.0),
        children: data.map((e) => buildImageTile(e)).toList(),
      ),
    );
  }

  Widget buildImageTile(News data) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network("$url/images/${data.image}"),
              ),
            );
          },
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage("$url/images/${data.image}"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
