import 'package:flutter/material.dart';
import 'package:kesehatan/models/general_response.dart';
import 'package:kesehatan/pages/login.dart';
import 'package:kesehatan/theme/theme.dart';
import 'package:kesehatan/utils/constant.dart';
import 'package:kesehatan/widgets/custom_checkbox.dart';
import 'package:kesehatan/widgets/primary_button.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  Future<GeneralResponse?> register() async {
    try {
      http.Response res =
          await http.post((Uri.parse('$url/user/register')), body: {
        'username': usernameController.text,
        'password': passwordController.text,
        'name': nameController.text,
        'email': emailController.text,
      });

      GeneralResponse data = generalResponseFromJson(res.body);

      if (data.success) {
        setState(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message)));
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const LoginPage()));
        });
      } else {
        setState(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message)));
        });
      }
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
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create an account',
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
                          controller: nameController,
                          validator: (value) {
                            return value!.isEmpty
                                ? "Name can't be empty"
                                : null;
                          },
                          style: regular16pt,
                          decoration: InputDecoration(
                              hintText: 'Name',
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
                          controller: emailController,
                          validator: (value) {
                            return value!.isEmpty
                                ? "Email can't be empty"
                                : null;
                          },
                          style: regular16pt,
                          decoration: InputDecoration(
                              hintText: 'Email',
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
                                    borderSide: BorderSide.none))),
                      ),
                    ],
                  )),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomCheckbox(),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'By creating an account, you agree to our',
                        style: regular16pt.copyWith(color: textGrey),
                      ),
                      Text(
                        'Term & Condition',
                        style: regular16pt.copyWith(color: primary),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32),
              CustomPrimaryButton(
                buttonColor: primary,
                textValue: 'Register',
                textColor: Colors.white,
                onTap: register,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: Text(
                      'Login',
                      style: regular16pt.copyWith(color: primary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
