import 'package:flutter/material.dart';
import 'package:kesehatan/pages/news_list.dart';
import 'package:kesehatan/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // proses do in background
  // initState : proses di background yang dilakukan sebelum view dipanggil
  // state : proses di background yang dilakukan saat perubahan view

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: const [
          NewsListPage(),
          ProfilePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            controller: tabController,
            tabs: const [
              Tab(
                text: "List Berita",
                icon: Icon(Icons.input),
              ),
              Tab(
                text: "Gallery Photos",
                icon: Icon(Icons.photo_album),
              ),
              Tab(
                text: "List Karyawan",
                icon: Icon(Icons.list),
              ),
            ]),
      ),
    );
  }
}
