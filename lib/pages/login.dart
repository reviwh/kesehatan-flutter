import 'package:flutter/material.dart';
import 'package:kesehatan/models/general_response.dart';
import 'package:kesehatan/pages/home_page.dart';
import 'package:kesehatan/pages/register.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:kesehatan/utils/constant.dart';
import 'package:kesehatan/utils/session_manager.dart';
import 'package:kesehatan/widgets/custom_checkbox.dart';
import 'package:kesehatan/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  Future<GeneralResponse?> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response res =
          await http.post((Uri.parse('$url/user/login')), body: {
        'username': usernameController.text,
        'password': passwordController.text,
      });

      GeneralResponse data = generalResponseFromJson(res.body);

      if (data.success) {
        setState(() {
          isLoading = false;
          sessionManager.saveSession(usernameController.text, true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomePage()));
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to your account',
                    style: heading2.copyWith(color: textBlack),
                  ),
                  const SizedBox(height: 16),
                  Image.asset(
                    'images/accent.png',
                    width: 99,
                    height: 4,
                  )
                ],
              ),
              const SizedBox(height: 48),
              Form(
                  key: keyForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            return value!.isEmpty
                                ? "Username can't be empty"
                                : null;
                          },
                          style: regular16pt,
                          decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            return value!.isEmpty
                                ? "Password can't be empty"
                                : null;
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
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      )
                    ],
                  )),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomCheckbox(),
                  const SizedBox(width: 12),
                  Text(
                    'Remember me',
                    style: regular16pt,
                  )
                ],
              ),
              const SizedBox(height: 32),
              CustomPrimaryButton(
                buttonColor: primary,
                textValue: 'Login',
                textColor: Colors.white,
                enabled: !isLoading,
                onTap: () {
                  if (keyForm.currentState!.validate()) {
                    login();
                  } else {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter all fields")));
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Doesn't have an account yet? ",
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: Text(
                      'Register',
                      style: regular16pt.copyWith(color: primary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
