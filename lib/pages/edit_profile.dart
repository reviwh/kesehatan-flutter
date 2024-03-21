import 'package:flutter/material.dart';
import 'package:kesehatan/models/general_response.dart';
import 'package:kesehatan/models/users.dart';
import 'package:kesehatan/pages/profile.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:http/http.dart' as http;
import 'package:kesehatan/utils/constant.dart';
import 'package:kesehatan/widgets/primary_button.dart';

class EditProfilePage extends StatefulWidget {
  final User? user;
  const EditProfilePage({this.user, super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    User data = widget.user!;
    nameController.text = data.name;
    emailController.text = data.email;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primary),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => const ProfilePage())));
          },
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: "Back",
        ),
        title: Text('Edit Profile', style: heading2.copyWith(color: primary)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: textWhiteGrey,
                  borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  return value!.isEmpty ? "Name can't be empty" : null;
                },
                style: regular16pt,
                decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: heading6.copyWith(color: textGrey),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: textWhiteGrey,
                  borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return value!.isEmpty ? "Email can't be empty" : null;
                },
                style: regular16pt,
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: heading6.copyWith(color: textGrey),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: textWhiteGrey,
                  borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  return value!.isEmpty ? "Password can't be empty" : null;
                },
                obscureText: !passwordVisible,
                style: regular16pt,
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: heading6.copyWith(color: textGrey),
                    suffixIcon: IconButton(
                      color: textGrey,
                      splashRadius: 1,
                      icon: Icon(passwordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded),
                      onPressed: togglePassword,
                    ),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
            const SizedBox(height: 20),
            CustomPrimaryButton(
              onTap: saveProfileChanges,
              textValue: "Save Changes",
              textColor: Colors.white,
              buttonColor: primary,
              enabled: !isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveProfileChanges() async {
    String username = widget.user!.username;
    String newName = nameController.text.trim();
    String newEmail = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      http.Response res = await http.post(Uri.parse("$url/user/update"), body: {
        "name": newName,
        "email": newEmail,
        "password": password,
        "username": username,
      });

      GeneralResponse data = generalResponseFromJson(res.body);

      if (data.success) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message)));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }
}
