import 'package:flutter/material.dart';
import 'package:game_store_app/data/notifier.dart';
import 'package:game_store_app/services/auth_service.dart';
import 'package:game_store_app/views/filter_page.dart';
import 'package:game_store_app/views/home.dart';
import 'package:game_store_app/views/landing_game_page.dart';
import 'package:game_store_app/views/login_page.dart';
import 'package:game_store_app/views/posts_page.dart';
import 'package:game_store_app/widgets/bottomNavbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final AuthService _authService = AuthService();

List<Widget> pages = [
  PostsPage(),
  Home(),
  // FriendsPage(),
  LandingGamePage(),
  FilterPage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  void _logout(BuildContext context) {
    _authService.logout(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ValueListenableBuilder(
              valueListenable: selectedPageNotifier,
              builder: (context, selectedPage, child) {
                return pages.elementAt(selectedPage);
              }),
          drawer: Drawer(
            child: Column(
              children: [
                ListTile(
                  title: Text("Logout"),
                )
              ],
            ),
          ),
          // floatingActionButton: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     FloatingActionButton(
          //       onPressed: () {},
          //       child: Icon(Icons.add),
          //     ),
          //     SizedBox(
          //       height: 10,
          //     ),
          //     FloatingActionButton(
          //       onPressed: () {},
          //       child: Icon(Icons.add),
          //     )
          //   ],
          // ),
          bottomNavigationBar: BottomNavBarWidget()),
    );
  }
}
