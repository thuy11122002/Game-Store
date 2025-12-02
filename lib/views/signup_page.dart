import 'package:flutter/material.dart';
import 'package:game_store_app/main.dart';
import 'package:game_store_app/services/auth_service.dart';
import 'package:game_store_app/views/home.dart';
import 'package:game_store_app/views/landing_game_page.dart';
import 'package:game_store_app/views/login_page.dart';
import 'package:game_store_app/widgets/snackBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool isLoadin = false;

  void _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (!email.contains(".com")) {
      showSnackBar(context, "Tai khoan email ko hop le");
    }

    setState(() {
      isLoadin = true;
    });

    final result = await _authService.signUp(email, password);

    if (result == null) {
      setState(() {
        isLoadin = false;
      });
      showSnackBar(context, "Dang ky thanh cong, dang chuyen man hinh");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage()));
    } else {
      setState(() {
        isLoadin = false;
      });
      showSnackBar(context, "Dang ky that bai: $result");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(27, 8, 40, 1),
          Color.fromRGBO(27, 8, 40, 1),
          Color.fromRGBO(27, 8, 40, 1),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 80),
              Text("Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      color: Color.fromRGBO(109, 76, 146, 1),
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || !value.contains('@')
                    ? "Enter a valid email"
                    : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
                validator: (value) => value == null || value.length < 6
                    ? "Password too short"
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signUp(),
                child: isLoadin ? CircularProgressIndicator() : Text("Sign Up"),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                  );
                },
                child: Text("Already have an account? Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
