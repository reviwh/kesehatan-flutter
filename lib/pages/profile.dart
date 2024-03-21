import 'package:flutter/material.dart';
import 'package:kesehatan/models/users.dart';
import 'package:kesehatan/pages/edit_profile.dart';
import 'package:kesehatan/pages/home_page.dart';
import 'package:kesehatan/pages/login.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:kesehatan/utils/constant.dart';
import 'package:kesehatan/utils/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:kesehatan/widgets/primary_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  bool isLoading = true;

  Future<void> logout() async {
    sessionManager.deleteSession();
    setState(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    });
  }

  Future<void> getUser(String username) async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.get(Uri.parse("$url/user/$username"));
      setState(() {
        user = userFromJson(res.body);
        isLoading = false;
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
    sessionManager.getUsername().then((value) => {
          value != null
              ? getUser(value)
              : Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false)
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primary),
        title: Text('Profile', style: heading2.copyWith(color: primary)),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Text(
                        user?.name[0] ?? 'A',
                        style: heading2.copyWith(
                          fontSize: 48,
                          color: darkGreen,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user?.name ?? 'Anonymous',
                      style: heading2,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user?.email ?? 'anonymous@example.net',
                      style: heading5,
                    ),
                    const SizedBox(height: 64),
                    CustomPrimaryButton(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditProfilePage(user: user)));
                      },
                      textValue: "Edit Profile",
                      buttonColor: primary,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    CustomPrimaryButton(
                      onTap: logout,
                      textValue: "Sign Out",
                      buttonColor: Colors.red.shade400,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
