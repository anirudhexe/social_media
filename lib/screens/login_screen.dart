import 'package:flutter/material.dart';
import 'package:social_media/resources/firebase_auth.dart';
import 'package:social_media/screens/signup_screen.dart';
import 'package:social_media/utils/colors.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive/mb_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthProvider().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);
    print(res);

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => const ResponsiveLayout(
                  moblileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout()))));
    } else {
      showSnackbar(res, context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/doglagram_logo.png'),
                Column(
                  children: [
                    TextFieldInput(
                      hinttext: 'enter email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: _emailcontroller,
                      password: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hinttext: 'enter password',
                      textInputType: TextInputType.visiblePassword,
                      textEditingController: _passwordcontroller,
                      password: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () {
                    loginUser();
                  },
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: const ShapeDecoration(
                              color: purpleColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                          child: Text(
                            'login',
                            style: GoogleFonts.workSans(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: const Text('Don\'t have an account?'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: const Text(
                          'Create account',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
