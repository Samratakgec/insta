import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaudemy/resources/auth.dart';
import 'package:instaudemy/responsive/mobscreenlayout.dart';
import 'package:instaudemy/responsive/responsivelayout.dart';
import 'package:instaudemy/responsive/webscreenlayout.dart';
import 'package:instaudemy/utils/colors.dart';
import 'package:instaudemy/utils/utils.dart';
import 'package:instaudemy/widgets/text_field_input.dart';

class SignUpState extends StatefulWidget {
  const SignUpState({super.key});

  @override
  State<SignUpState> createState() => _SignUpStateState();
}

class _SignUpStateState extends State<SignUpState> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  final _usernameController = TextEditingController();
  Uint8List? _image;
  bool isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void SignUp() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
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
  }

  void setImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
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
                          //  height: 64,
                        ),
                      ),
                    ),
                    //circular widget
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!))
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQykly5v4_YjTkrJBJxiEvG_7jGGiTWRCpNXZRogw0YdA&s'),
                                ),
                          Positioned(
                              bottom: -3,
                              left: 80,
                              child: InkWell(
                                onTap: () {
                                  setImage();
                                },
                                child: const Icon(Icons.add_a_photo),
                              ))
                        ],
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
                    //username
                    TextFieldInput(
                      textEditingController: _usernameController,
                      hintText: 'Enter your username',
                      textInputType: TextInputType.text,
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
                    // bio
                    TextFieldInput(
                      textEditingController: _bioController,
                      hintText: 'Enter your bio',
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //button
                    GestureDetector(
                      onTap: () async {
                        SignUp();
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
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: primaryColor,
                              ))
                            : const Text('SignUp'),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
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
