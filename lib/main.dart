import 'package:flutter/material.dart';
import 'package:otaku_stream/Models/anime_detail.dart';
import 'package:otaku_stream/Providers/genre_provider.dart';
import 'package:otaku_stream/Providers/stream_provider.dart';
import 'package:otaku_stream/Screens/HomePage.dart';
import 'package:otaku_stream/Screens/explorepage.dart';
import 'package:otaku_stream/Screens/login_screen.dart';
import 'package:otaku_stream/Widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'Providers/detail_provider.dart';
import 'Providers/episode_provider.dart';
import 'Providers/home_provider.dart';
import 'Providers/server_provider.dart';

void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((value){
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeProvider()),
          ChangeNotifierProvider(create: (context) => DetailProvider()),
          ChangeNotifierProvider(create: (_) => EpisodeProvider()),
          ChangeNotifierProvider(create: (_) => ServerProvider()),
          ChangeNotifierProvider(create: (_) => StreamingProvider()),
          ChangeNotifierProvider(create: (_) => GenreProvider()),
        ],
        child: const AnimeApp(),
      ),
    );
  //});
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
        initialRoute: '/',
        routes: {
          '/': (context) => const NavigationWrapper(),//AnimeLoginScreen()
          '/page1': (context) => const ExplorePage(),
          '/page2': (context) => const AnimeHomeScreen(),
        },
        //home: NavigationWrapper()//AdvancedVideoPlayer()//const VideoPlayerScreen(hlsUrl: "https://gg3.biananset.net/_v7/74a50cfd4c1c68eb65e43d21048f2e2dad2e8db6b42e757ada8fbfd1b4fb38d74b1c23d794f22381a22e44f43c7733f840067afe2e967767eb8a99a3c03102440da0706c30b5e4ed0751e68d7ffd5a686afffad7e16b4c77f16bf345606bdeab79112d52a761e9e003f90a8008a67d833314df0265b6c93971604bd7d00d4179/master.m3u8", episodes: ["vlkdn", "akjsb","d"],),
    );
  }
}
