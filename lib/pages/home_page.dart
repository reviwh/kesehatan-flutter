import 'package:flutter/material.dart';
import 'package:kesehatan/pages/employee.dart';
import 'package:kesehatan/pages/gallery.dart';
import 'package:kesehatan/pages/login.dart';
import 'package:kesehatan/pages/news_list.dart';
import 'package:kesehatan/pages/profile.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:kesehatan/utils/session_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    sessionManager.getUsername().then((value) => {
          setState(() {
            if (value == null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            }
          })
        });
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 48,
              height: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              "HealthCare",
              style: heading2.copyWith(color: primary),
            )
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
              });
            },
            icon: const Icon(Icons.person_rounded),
            color: primary,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          NewsListPage(),
          GalleryPage(),
          EmployeePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 84,
        child: TabBar(
            tabAlignment: TabAlignment.fill,
            isScrollable: false,
            labelColor: primary,
            unselectedLabelColor: textGrey,
            controller: tabController,
            tabs: const [
              Tab(
                text: "News",
                icon: Icon(Icons.newspaper_rounded),
              ),
              Tab(
                text: "Gallery",
                icon: Icon(Icons.photo_library_rounded),
              ),
              Tab(
                text: "Employees",
                icon: Icon(Icons.group_rounded),
              ),
            ]),
      ),
    );
  }
}
