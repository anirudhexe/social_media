// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screens/add_post_screen.dart';
import 'package:social_media/screens/feed_screen.dart';
import 'package:social_media/screens/search_screen.dart';
import 'package:social_media/utils/colors.dart';

import '../screens/profile_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //this function helps us to navigate to different pages
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  //this function recieves an argument holding the current page number and it sets the globl page variable to that page number which helps us to change the colour of the icons
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: [
          FeedScreen(),
          SearchScreen(),
          AddPostScreen(),
          Text('notifications'),
          ProfileScreen(
            uid: FirebaseAuth.instance.currentUser!.uid,
          )
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor, // Set the background color here

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _page == 0 ? Icons.home : Icons.home_outlined,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 1 ? Icons.search : Icons.search_outlined,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 2 ? Icons.add_box : Icons.add_box_outlined,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 3 ? Icons.notifications : Icons.notifications_outlined,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 4 ? Icons.person : Icons.person_outlined,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
        ],
        onTap: navigationTapped,
        //when we tap on a bottom nav icon the navigationTapped function gets called which helps to change pages
      ),
    );
  }
}
