import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/screens/add_post.dart';
import 'package:instagram_clone/screens/favourite_screen.dart';
import 'package:instagram_clone/screens/home%20screens/home_screen.dart';
import 'package:instagram_clone/screens/home%20screens/nav_home.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/screens/search_screen.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/screens/splash%20screen/splash_screen.dart';
import 'package:instagram_clone/screens/web_screen.dart';
import 'package:instagram_clone/utills/colors.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProivder()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        title: 'Instagram Clone',
        initialRoute: '/ResponsiveLayout',
        getPages: [
          GetPage(
              name: '/',
              page: () => const ResponsiveLayout(
                  webScreen: WebScreen(), mobileScreen: SplashScreen())),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/signin', page: () => const SignInScreen()),
          GetPage(name: '/home', page: () => const HomeScreen()),
          GetPage(name: '/navHome', page: () => const NavHomeScreen()),
          GetPage(name: '/Search', page: () => const SearchScreen()),
          GetPage(name: '/SelectImage', page: () => const SelectImage()),
          GetPage(name: '/Favourite', page: () => const FavScreen()),
          GetPage(name: '/profile', page: () => const ProfileScreen()),
        ],
      ),
    );
  }
}
