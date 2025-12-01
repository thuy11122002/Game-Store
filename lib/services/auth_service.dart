import 'package:flutter/material.dart';
import 'package:game_store_app/views/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // Dang ky

  Future<String?> signUp(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        password: password,
        email: email,
      );

      if (response.user != null) {
        return null;
      }

      return "Co loi khong biet xuat hien";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error: $e";
    }
  }

  // Dang nhap

  Future<String?> signIn(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user != null) {
        return null;
      }

      return "Email hoac mat khau khong hop le";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error: $e";
    }
  }

  // Dang xuat

  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return;
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    } catch (e) {
      print("Logout error $e");
    }
  }
}
