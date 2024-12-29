import 'package:flutter/material.dart';
import 'package:likya_app/common/widgets/container_image.dart';
import 'package:likya_app/presentation/auth/pages/login/login_screen.dart';
import 'package:likya_app/presentation/auth/pages/signup/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              bottom: 80,
              top: 80,
            ),
            child: Column(
              children: [
                //first page
                buildImageContainer(
                  Colors.white,
                  'Connexion/Inscription',
                  'Accédez à votre compte ou créez-en un en quelques clics pour profiter pleinement de l\'expérience Likya',
                  'assets/images/auth_screen.png',
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Login Button
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: const Color(0xFF2FA9A2),
                minimumSize: const Size(335, 45),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text(
                "Connexion",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //Signin button
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: const Color(0xFF2FA9A2),
                minimumSize: const Size(335, 45),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SignupScreen(),
                  ),
                );
              },
              child: const Text(
                "Inscription",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
