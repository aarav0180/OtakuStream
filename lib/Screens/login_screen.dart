import 'package:flutter/material.dart';
import 'package:otaku_stream/Screens/signup_screen.dart';

class AnimeLoginScreen extends StatefulWidget {
  @override
  State<AnimeLoginScreen> createState() => _AnimeLoginScreenState();
}

class _AnimeLoginScreenState extends State<AnimeLoginScreen> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/back.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.orange.withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Login Card
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Text("LOGIN", style: TextStyle(
                      color: Colors.white, fontSize: 48
                    ),),
                  ),
                  // Anime Character Image
                  SizedBox(
                    height: 240,
                    child: Image.asset(
                      'assets/images/back2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  //SizedBox(height: 20),
                  // Email Field
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Password Field
                  TextField(
                    obscureText: _obscureText,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 700),
                          transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                          child: _obscureText
                              ? const Icon(Icons.visibility_off, key: ValueKey('off'), color: Colors.orange)
                              : const Icon(Icons.visibility, key: ValueKey('on'), color: Colors.orange),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button with Design
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.vpn_key, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Forgot Password Text
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.orangeAccent),
                    ),
                  ),
                  //const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Don't have an account?", style: TextStyle(color: Colors.orangeAccent),),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          " Signup",
                          style: TextStyle(color: Colors.orangeAccent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}