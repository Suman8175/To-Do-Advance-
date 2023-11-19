import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/common/exception/exceptionshow.dart';
import 'package:todos/constants/image_constants.dart';
import 'package:todos/screens/homepage.dart';

import '../../config/themes/apptheme.dart';

import '../../widgets/textfield_common.dart';
import 'signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;

  //onclicked LoginButton Function
  void onTap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
        ),
      );
      try {
        await _auth.signInWithEmailAndPassword(
            email: userEmail.text.toString(),
            password: userPassword.text.toString());
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement((context),
            MaterialPageRoute(builder: (context) => const HomePage()));
        userEmail.text = '';
        userPassword.text = '';
        setState(() {
          loading = false;
        });
      } on FirebaseAuthException catch (e) {
        ExceptionShower().showmessage(e.message!);
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Color.fromRGBO(
                    2,
                    172,
                    84,
                    2,
                  ),
                  Color.fromRGBO(136, 198, 85, 2)
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImagePath.leafLogo,
                      height: 100,
                    ),
                    const Expanded(child: SizedBox()),
                    Image.asset(
                      ImagePath.leafLogo,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome\nBack',
                        style: TextStyle(
                            color: AppTheme.blackColor,
                            fontSize: 32,
                            // fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFiller(
                              value: userEmail.text.toString(),
                              newController: userEmail,
                              textFieldTitle: 'Enter your email',
                              obsecure: false,
                              // keyboardAction: TextInputAction.next,
                              iconToShow: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFiller(
                              value: userPassword.text.toString(),
                              newController: userPassword,
                              textFieldTitle: 'Enter your password',
                              obsecure: true,
                              keyboardAction: TextInputAction.done,
                              iconToShow: Icons.lock_outline_rounded,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: loading
                              ? null
                              : () {
                                  onTap(context);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(250, 167, 226, 176),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: loading
                              ? const CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: AppTheme.greyColor,
                                      fontSize: 18,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider(thickness: 2)),
                          Text('OR', style: TextStyle(fontSize: 16)),
                          Expanded(child: Divider(thickness: 2)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push((context),
                              MaterialPageRoute(builder: (context) {
                            return const SignUpPage();
                          }));
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 68, 122, 68),
                              Color.fromARGB(255, 156, 240, 156),
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                              child: Text(
                            'Create account',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.greyColor),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
