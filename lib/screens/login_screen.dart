import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instaudemy/resources/auth.dart';
import 'package:instaudemy/responsive/mobscreenlayout.dart';
import 'package:instaudemy/responsive/responsivelayout.dart';
import 'package:instaudemy/responsive/webscreenlayout.dart';
import 'package:instaudemy/screens/signup_screen.dart';
import 'package:instaudemy/utils/colors.dart';
import 'package:instaudemy/utils/utils.dart';
import 'package:instaudemy/widgets/text_field_input.dart';

class LoginState extends StatefulWidget {
  const LoginState({super.key});

  @override
  State<LoginState> createState() => _LoginStateState();
}

class _LoginStateState extends State<LoginState> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void login() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods().LogInUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      isloading = false;
    });

    if (res != 'success') {
      showSnackBar(res.toString(), context);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Responsive(
                  webScreenLayout: WebScreenLayout(),
                  mobileScreenLayout: MobScreenLayout())));
    }
    // print(res);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: Text('Instagram')),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //svg img
                    Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: SizedBox(
                        child: SvgPicture.asset(
                          'assets/ic_instagram.svg',
                          // ignore: deprecated_member_use
                          color: primaryColor,
                          height: 64,
                        ),
                      ),
                    ),
                    //textfield email
                    TextFieldInput(
                      textEditingController: _emailController,
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //textfield pwd
                    TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //button
                    GestureDetector(
                      onTap: () {
                        login();
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                            color: blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)))),
                        child: isloading
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: primaryColor),
                              )
                            : const Text('LogIn'),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    //transitioin to signup
                    Padding(
                      padding: const EdgeInsets.only(top: 200.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('New User?'),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpState()),
                              );
                            },
                            child: const Text(
                              'SignUp',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
