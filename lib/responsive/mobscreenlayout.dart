import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instaudemy/resources/auth.dart';
import 'package:instaudemy/screens/addpost.dart';
import 'package:instaudemy/screens/feed.dart';
import 'package:instaudemy/screens/notification.dart';
import 'package:instaudemy/screens/profile.dart';
import 'package:instaudemy/screens/search.dart';
import 'package:instaudemy/utils/colors.dart';

class MobScreenLayout extends StatefulWidget {
  const MobScreenLayout({super.key});

  @override
  State<MobScreenLayout> createState() => _MobScreenLayoutState();
}

class _MobScreenLayoutState extends State<MobScreenLayout> {
  String username = "e";
  late var timer;
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if (mounted) {
  //     getusername();
  //     timer = new Timer.periodic(
  //         Duration(seconds: 60), (Timer t) => setState(() {}));
  //   }
  // }

  // void getusername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   print(snap.data());
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  // void signout() async {
  //   await AuthMethods().signout();
  // }

  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        scrollBehavior: null,
        //scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
        children: [Feeds(), Search(), AddPostScreen(), Notif(), Profile()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mobileBackgroundColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: (_page == 0) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: (_page == 1) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: (_page == 2) ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: (_page == 3) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: (_page == 4) ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
