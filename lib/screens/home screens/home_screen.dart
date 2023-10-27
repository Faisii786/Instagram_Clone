// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/screens/favourite_screen.dart';
import 'package:instagram_clone/screens/home%20screens/nav_home.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/utills/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    addData();
    super.initState();
  }

  addData() async {
    UserProivder _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          NavHomeScreen(),
          SearchScreen(),
          SelectImage(),
          FavScreen(),
          ProfileScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor,
          unselectedItemColor: primaryColor,
          iconSize: 35,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: primaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: primaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: primaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: primaryColor,
              ),
              label: '',
              backgroundColor: mobileBackgroundColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: primaryColor,
              ),
              label: '',
              backgroundColor: greyColor,
            ),
          ]),
    );
  }
}
