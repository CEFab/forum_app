import 'package:flutter/material.dart';
import 'package:forum_app/controllers/authentication.dart';
import 'package:forum_app/views/register_page.dart';
import 'package:forum_app/views/widgets/input_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login Page',
                style: GoogleFonts.poppins(fontSize: size * 0.080)),
            const SizedBox(height: 30),
            InputWidget(
              hintText: 'Username',
              controller: _usernameController,
              obscureText: false,
            ),
            const SizedBox(height: 20),
            InputWidget(
              hintText: 'Password',
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              onPressed: () async {
                await _authenticationController.login(
                    username: _usernameController.text.trim(),
                    password: _passwordController.text.trim());
              },
              child: Obx(() {
                return _authenticationController.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('Login',
                        style: GoogleFonts.poppins(fontSize: size * 0.040));
              }),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(const RegisterPage());
              },
              child: Text('Register',
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.040, color: Colors.black)),
            ),
          ],
        ),
      ),
    ));
  }
}
