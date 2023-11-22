import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/common/exception/exceptionshow.dart';

import '../../config/themes/apptheme.dart';
import '../../constants/image_constants.dart';
import '../../widgets/textfield_common.dart';
import 'login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userSignInEmail = TextEditingController();
  TextEditingController userSignInPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  //onClicked signIn or Create account Button
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
        if (userSignInPassword == confirmPassword) {
          await _auth.createUserWithEmailAndPassword(
              email: userSignInEmail.text.toString(),
              password: userSignInPassword.text.toString());
          userSignInEmail.text = '';
          userSignInPassword.text = '';
          confirmPassword.text = '';
          setState(() {
            loading = false;
          });
          // ignore: use_build_context_synchronously
          _dialogBuilder(context);
        } else {
          setState(() {
            loading = false;
          });
          ExceptionShower().showmessage('Both passwords are different');
          userSignInPassword.text = '';
          confirmPassword.text = '';
        }
      } on FirebaseAuthException catch (e) {
        ExceptionShower().showmessage(e.message!);
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Account Created!'),
            content: const Text('Your account Has Been Created Sucessfully!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
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
                        "Let's\nGet Started",
                        style: TextStyle(
                            color: AppTheme.blackColor,
                            fontSize: 32,
                            // fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFiller(
                              value: userSignInEmail.text.toString(),
                              newController: userSignInEmail,
                              textFieldTitle: 'Enter your email',
                              obsecure: false,
                              // keyboardAction: TextInputAction.next,
                              iconToShow: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFiller(
                              value: userSignInPassword.text.toString(),
                              newController: userSignInPassword,
                              textFieldTitle: 'Enter your password',
                              obsecure: true,
                              iconToShow: Icons.lock_outline_rounded,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFiller(
                              value: confirmPassword.text.toString(),
                              newController: confirmPassword,
                              textFieldTitle: 'Retype password',
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
                                  'Create Account',
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
                          Navigator.pushReplacement((context),
                              MaterialPageRoute(builder: (context) {
                            return const LoginPage();
                          }));
                        },
                        child: Center(
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width * 0.65,
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
                              'Log In',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.greyColor),
                            )),
                          ),
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
