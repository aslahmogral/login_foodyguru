import 'package:flutter/material.dart';
import 'package:foodyguru_loginscreen/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

String password = 'password';
String checkPassword = '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _validateEmailform = GlobalKey<FormState>();
  late SharedPreferences prefs;

  String email = 'aslah@gmail.com';
  TextEditingController emailController = TextEditingController();
  TextEditingController emailValidatorController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Lottie.asset(
                        'asset/animation/83168-login-success.json',
                        height: 250)),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:const [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'Kodchasan',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.alternate_email),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextFormField(
                              validator: (value) {
                                if (value!.isNotEmpty &&
                                    emailController.text == email) {
                                  return null;
                                } else if (value.isEmpty) {
                                  return 'enter your email address';
                                } else {
                                  return 'email is incorrect';
                                }
                              },
                              controller: emailController,
                              decoration: const InputDecoration(
                                  hintText: 'Email ID',
                                  hintStyle:
                                      TextStyle(fontFamily: 'Kodchasan')),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.key),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: TextFormField(
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'enter your password';
                                }
                              },
                              obscureText: true,
                              controller: passwordController,
                              decoration: const InputDecoration(
                                  hintText: 'Password',
                                  hintStyle:
                                      TextStyle(fontFamily: 'kodachan')),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(fontFamily: 'kodachan'),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (!_formkey.currentState!.validate()) {
                                  return;
                                }
                                prefs = await SharedPreferences.getInstance();

                                final pass = prefs.getString(password);
                               
                                if (emailController.text == email &&
                                    pass == passwordController.text) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()));
                                }
                              },
                              child: const Text('Log in ',
                                  style: TextStyle(
                                      fontFamily: 'kodachan', fontSize: 19)),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: isVisible,
                          child: Container(
                            color: Color.fromARGB(255, 222, 221, 221),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Validate Email',
                                    style: TextStyle(
                                        fontFamily: 'Kodchasan',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Form(
                                    key: _validateEmailform,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.alternate_email),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: TextFormField(
                                          controller:
                                              emailValidatorController,
                                          validator: (value) {
                                            if (value!.isNotEmpty &&
                                                emailValidatorController
                                                        .text ==
                                                    email) {
                                              return null;
                                            } else {
                                              return 'enter valid email id';
                                            }
                                          },
                                          decoration: const InputDecoration(
                                              hintText: 'Email ID',
                                              hintStyle: TextStyle(
                                                  fontFamily: 'Kodchasan')),
                                        )),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!_validateEmailform
                                              .currentState!
                                              .validate()) {
                                            return;
                                          }
                                          dialogBox(context);
                                          setState(() {
                                            isVisible = !isVisible;
                                          });
                                        },
                                        child: const Text('Submit ',
                                            style: TextStyle(
                                                fontFamily: 'kodachan',
                                                fontSize: 19)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialogBox(BuildContext context) {
    TextEditingController newPassword = TextEditingController();
    TextEditingController oldPassword = TextEditingController();
    final GlobalKey<FormState> _resetPasswordKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Form(
              key: _resetPasswordKey,
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(
                        'Reset Password',
                        style: TextStyle(
                            fontFamily: 'Kodchasan',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.key),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return 'enter new password';
                              }
                            },
                            controller: newPassword,
                            decoration: const InputDecoration(
                                hintText: 'New Password',
                                hintStyle: TextStyle(fontFamily: 'Kodchasan')),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.key),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            validator: (value) {
                              if (value!.isNotEmpty &&
                                  newPassword.text == oldPassword.text) {
                                save(newPassword);

                                return null;
                              } else {
                                return 'entered password correctly';
                              }
                            },
                            controller: oldPassword,
                            decoration: const InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(fontFamily: 'Kodchasan')),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_resetPasswordKey.currentState!.validate()) {
                                return;
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Submit ',
                                style: TextStyle(
                                    fontFamily: 'kodachan', fontSize: 19)),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  save(TextEditingController controller) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString(password, controller.text.toString());
   
  }
}
