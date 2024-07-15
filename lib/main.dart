import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instaudemy/firebase_options.dart';
import 'package:instaudemy/responsive/mobscreenlayout.dart';
import 'package:instaudemy/responsive/responsivelayout.dart';
import 'package:instaudemy/responsive/webscreenlayout.dart';
// import 'package:instaudemy/responsive/mobscreenlayout.dart';
// import 'package:instaudemy/responsive/responsivelayout.dart';
// import 'package:instaudemy/responsive/webscreenlayout.dart';
import 'package:instaudemy/screens/login_screen.dart';
import 'package:instaudemy/screens/signup_screen.dart';

import 'package:instaudemy/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),

        // home: Responsive(
        //     webScreenLayout: WebScreenLayout(),
        //     mobileScreenLayout: MobScreenLayout())
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const Responsive(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              ));
            }
            return LoginState();
          },
        ));
  }
}
