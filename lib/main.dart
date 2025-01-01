import 'package:flutter/material.dart';
import 'package:otaku_stream/Widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'Providers/detail_provider.dart';
import 'Providers/home_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => DetailProvider()), // Add other providers here
      ],
    child: const AnimeApp(),
  ),);
}

class AnimeApp extends StatelessWidget {
  const AnimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const NavigationWrapper(),
    );
  }
}
