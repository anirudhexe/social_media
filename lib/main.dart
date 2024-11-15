import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/user_provider.dart';
import 'package:social_media/responsive/mb_screen_layout.dart';
import 'package:social_media/responsive/responsive.dart';
import 'package:social_media/responsive/web_screen_layout.dart';
import 'package:social_media/screens/login_screen.dart';
import 'utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: StreamBuilder(
              stream: FirebaseAuth.instance
                  .authStateChanges(), // authstatechanges changes the log in state of the app only when user manually logs in or sign out
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  // whether connection has been established with the firebase stream

                  if (snapshot.hasData) {
                    //if snapshot has data that means user has been authenticated
                    return const ResponsiveLayout(
                        moblileScreenLayout: MobileScreenLayout(),
                        webScreenLayout: WebScreenLayout());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Some internal error occurred'),
                    );
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                }
                return const LoginScreen();
              })),
    );
  }
}
