import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/screens/new_login_screen.dart';
import 'package:instagram_flutter/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/responsive/new_web_screen_layout.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCK1dFpZ_qT8t2lOYiPSYi157Pim0Z9bmo",
            appId: "1:78905418631:web:52585f70a751a772d32922",
            messagingSenderId: "78905418631",
            projectId: "insta-clone-3b1ec",
            storageBucket: "insta-clone-3b1ec.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Flutter',

        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
            inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: TextStyle(color: greenColor),
            )),
        // home: Scaffold(
        //   body: ResponsiveLayout(
        //       webScreenLayout: WebScreenLayout(),
        //       mobileScreenLayout: MobileScreenLayout()),
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //idtokenchanges  -FirebaseAuth.instance.idTokenChanges() - all token signin/out change
            //userchange- sign in/out + password update then state changes
            //authstate changes only signin/out
            if (snapshot.connectionState == ConnectionState.active) {
              //connection is made w out screen{
              //if snap has data or not
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: greenColor),
              );
            }
            return const LoginScreen(); //snapshot doesnt have any data user hasnt been authenticated
          },
        ),
      ),
    );
  }
}
