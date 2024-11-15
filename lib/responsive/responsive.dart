import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/user_provider.dart';
import 'package:social_media/utils/dimensions.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget moblileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.moblileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    addData();
    super.initState();
  }

  //this function will help to fetch the user details from the user provider
  void addData() async {
    UserProvider _userProvider = Provider.of(context,
        listen:
            false); //listen: false makes sure that the value of the userProvider changes only once and not everytime there's a change.
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //web Screen
        return widget.webScreenLayout;
      } else {
        //mobile Screen
        return widget.moblileScreenLayout;
      }
    }));
  }
}
