import 'package:flutter/material.dart';
import 'package:kesehatan/models/news.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:kesehatan/utils/constant.dart';
import 'package:intl/intl.dart';

class NewsDetailsPage extends StatelessWidget {
  final News? data;
  const NewsDetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                "$url/images/${data?.image}",
                width: MediaQuery.of(context).size.width,
                height: 256,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                top: 16,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text(data!.title, style: heading6),
                  subtitle: Text(
                    DateFormat().format(data!.date),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(right: 16, bottom: 16, left: 16),
                  child: Text(
                    data!.body,
                    style: regular16pt.copyWith(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
