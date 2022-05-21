import 'package:flutter/material.dart';
import 'package:foodyguru_loginscreen/home_screen.dart';
import 'package:foodyguru_loginscreen/widgets/custom_textfield.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

String password = 'password';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _validateEmailform = GlobalKey<FormState>();
  late SharedPreferences prefs;

  //-------validators------------
  String? customPasswordValidtaor(String? fieldContent) =>
      fieldContent!.isEmpty ? 'please enter password' : null;
  String? customEmailValidtaor(String? fieldContent) {
    if (fieldContent!.isNotEmpty && emailController.text == email) {
      return null;
    } else if (fieldContent.isEmpty) {
      return 'enter your email address';
    } else {
      return 'email is incorrect';
    }
  }
  //-----------------------

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
                sizedBox(20, 0),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Lottie.asset(
                        'asset/animation/83168-login-success.json',
                        height: 250)),
                sizedBox(20, 0),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        heading("Login", 40, MainAxisAlignment.start),
                        sizedBox(25, 0),
                        CustomTextfield(
                          controller: emailController,
                          validator: customEmailValidtaor,
                          isTextObscured: false,
                          hintText: 'email is aslah@gmail.com',
                          leadingIcon: Icons.alternate_email,
                        ),
                        sizedBox(13, 0),
                        CustomTextfield(
                          controller: passwordController,
                          validator: customPasswordValidtaor,
                          isTextObscured: true,
                          hintText: 'Password',
                          leadingIcon: Icons.key,
                        ),
                        sizedBox(15, 0),
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
                        sizedBox(10, 0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              loginButtonMethod();
                            },
                            child: const Text('Login ',
                                style: TextStyle(
                                    fontFamily: 'kodachan', fontSize: 19)),
                          ),
                        ),
                        sizedBox(20, 0),
                        hiddenEmailValidationSection(context)
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

  Visibility hiddenEmailValidationSection(BuildContext context) {
    String? hiddenEmailValidator(String? fieldContent) {
      if (fieldContent!.isNotEmpty && emailValidatorController.text == email) {
        return null;
      } else {
        return 'enter valid email id';
      }
    }

    return Visibility(
      visible: isVisible,
      child: Container(
        color: const Color.fromARGB(255, 222, 221, 221),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              heading('Validate Email', 20, MainAxisAlignment.center),
              sizedBox(10, 0),
              Form(
                  key: _validateEmailform,
                  child: CustomTextfield(
                      controller: emailValidatorController,
                      validator: hiddenEmailValidator,
                      isTextObscured: false,
                      leadingIcon: Icons.alternate_email,
                      hintText: 'Email')),
              sizedBox(10, 0),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_validateEmailform.currentState!.validate()) {
                        return;
                      }
                      dialogBox(context);
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: const Text('Submit ',
                        style: TextStyle(fontFamily: 'kodachan', fontSize: 19)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Row heading(String heading, double fontSize, alignment) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Text(
          heading,
          style: TextStyle(
              fontFamily: 'Kodchasan',
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.black54),
        ),
      ],
    );
  }

  SizedBox sizedBox(double heightSpace, double widthSpace) {
    return SizedBox(height: heightSpace, width: widthSpace);
  }

  void loginButtonMethod() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    prefs = await SharedPreferences.getInstance();

    final pass = prefs.getString(password);

    if (emailController.text == email && pass == passwordController.text) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  Future<dynamic> dialogBox(BuildContext context) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController oldPasswordController = TextEditingController();

    String? customNewPasswordValidator(String? fieldContent) {
      if (fieldContent!.isNotEmpty) {
        return null;
      } else {
        return 'enter new password';
      }
    }

    String? customConfirmPasswordValidator(String? fieldContent) {
      if (fieldContent!.isNotEmpty && newPasswordController.text == oldPasswordController.text) {
        save(newPasswordController);
        return null;
      } else {
        return 'enterd password does not match';
      }
    }

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
                      heading('Reset Password', 20, MainAxisAlignment.center),
                      sizedBox(10, 0),
                      CustomTextfield(
                          controller: newPasswordController,
                          validator: customNewPasswordValidator,
                          isTextObscured: false,
                          leadingIcon: Icons.key,
                          hintText: 'Enter New Password'),
                      sizedBox(10, 0),
                      
                      CustomTextfield(controller: oldPasswordController, validator: customConfirmPasswordValidator, isTextObscured: false, leadingIcon: Icons.key, hintText: 'Confirm password')
                      ,const SizedBox(
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
