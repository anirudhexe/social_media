import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/screens/login_screen.dart';
import 'package:social_media/utils/utils.dart';
import 'package:social_media/widgets/text_field.dart';
import 'package:social_media/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/resources/firebase_auth.dart';

import '../responsive/mb_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _biocontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthProvider().signUpUser(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        username: _usernamecontroller.text,
        bio: _biocontroller.text,
        file: _image!);
    print(res);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success')
      showSnackbar(res, context);
    else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => const ResponsiveLayout(
                  moblileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout()))));
    }
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
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 50, backgroundImage: MemoryImage(_image!))
                        : const CircleAvatar(
                            radius: 50,
                            backgroundImage: CachedNetworkImageProvider(
                                'https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 70,
                        child: SizedBox(
                          width: 30,
                          child: FloatingActionButton(
                            backgroundColor: purpleColor,
                            mini: true,
                            onPressed: () {
                              selectImage();
                            },
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    TextFieldInput(
                      hinttext: 'enter username',
                      textInputType: TextInputType.text,
                      textEditingController: _usernamecontroller,
                      password: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hinttext: 'enter bio (optional)',
                      textInputType: TextInputType.text,
                      textEditingController: _biocontroller,
                      password: false,
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
                    signUpUser();
                  },
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: primaryColor,
                        ))
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
                            'sign up',
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
                      child: const Text('Already have an account?'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: const Text(
                          'Login',
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
