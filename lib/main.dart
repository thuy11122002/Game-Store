import 'package:flutter/material.dart';
import 'package:game_store_app/views/filter_page.dart';
import 'package:game_store_app/views/home.dart';
import 'package:game_store_app/views/landing_game_page.dart';
import 'package:game_store_app/views/login_page.dart';
import 'package:game_store_app/views/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://jvflvvordvqwrjyokfpy.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2Zmx2dm9yZHZxd3JqeW9rZnB5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM2MTg2NjUsImV4cCI6MjA3OTE5NDY2NX0.ZLw7eppsOi1ddhrr9xjPntEqGY5KwCWNQYHHuFiyRj0");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: SignupPage(),
        ));
  }
}
