import 'package:flutter/material.dart';
import 'package:game_store_app/views/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _rememberMe = false;

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Forgot Password"),
        content: Text("Reset link functionality not implemented yet."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
        ],
      ),
    );
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
              Text("Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      color: Color.fromRGBO(109, 76, 146, 1),
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: "Email", border: OutlineInputBorder()),
                validator: (value) => value == null || !value.contains('@')
                    ? "Enter a valid email"
                    : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password", border: OutlineInputBorder()),
                validator: (value) => value == null || value.length < 6
                    ? "Password too short"
                    : null,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (val) {
                      setState(() => _rememberMe = val!);
                    },
                  ),
                  Text("Remember Me"),
                  Spacer(),
                  TextButton(
                    onPressed: _forgotPassword,
                    child: Text("Forgot Password?"),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => {},
                child: Text("Login"),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SignupPage()),
                  );
                },
                child: Text("Don't have an account? Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
